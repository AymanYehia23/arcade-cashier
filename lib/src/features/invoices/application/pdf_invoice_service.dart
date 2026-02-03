import 'dart:typed_data';

import 'package:arcade_cashier/src/features/billing/domain/session_bill.dart';
import 'package:arcade_cashier/src/features/invoices/domain/invoice.dart';
import 'package:arcade_cashier/src/features/invoices/domain/invoice_item.dart';
import 'package:arcade_cashier/src/features/orders/domain/order.dart';
import 'package:arcade_cashier/src/features/sessions/domain/session.dart';
import 'package:arcade_cashier/src/features/settings/data/printer_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pdf_invoice_service.g.dart';

@riverpod
PdfInvoiceService pdfInvoiceService(PdfInvoiceServiceRef ref) {
  return PdfInvoiceService(ref);
}

/// Service for generating invoice PDFs optimized for thermal printers.
class PdfInvoiceService {
  final PdfInvoiceServiceRef _ref;

  PdfInvoiceService(this._ref);

  /// Generates invoice PDF and handles printing (silent if default set, else dialog).
  Future<Uint8List> printInvoice({
    required Invoice invoice,
    required Session session,
    required List<Order> orders,
    required SessionBill bill,
  }) async {
    final pdfBytes = await generateInvoicePdf(
      invoice: invoice,
      session: session,
      orders: orders,
      bill: bill,
    );

    await _printPdf(pdfBytes, invoice.invoiceNumber);

    return pdfBytes;
  }

  Future<void> _printPdf(Uint8List pdfBytes, String invoiceNumber) async {
    final printerRepo = _ref.read(printerRepositoryProvider);
    final defaultPrinterUrl = await printerRepo.loadDefaultPrinter();
    Printer? targetPrinter;

    if (defaultPrinterUrl != null) {
      final printers = await Printing.listPrinters();
      try {
        targetPrinter = printers.firstWhere((p) => p.url == defaultPrinterUrl);
      } catch (_) {
        // Printer not found in current list, fallback to dialog
        targetPrinter = null;
      }
    }

    if (targetPrinter != null) {
      await Printing.directPrintPdf(
        printer: targetPrinter,
        onLayout: (format) async => pdfBytes,
        name: 'Invoice-$invoiceNumber',
      );
    } else {
      await Printing.layoutPdf(
        onLayout: (format) async => pdfBytes,
        name: 'Invoice-$invoiceNumber',
      );
    }
  }

  /// Generates a PDF invoice optimized for 80mm thermal printer roll.
  Future<Uint8List> generateInvoicePdf({
    required Invoice invoice,
    required Session
    session, // Still needed for specific session details if any, but duration comes from bill
    required List<Order> orders,
    required SessionBill bill,
  }) async {
    final pdf = pw.Document();

    // Build invoice items list
    final items = _buildInvoiceItems(orders: orders, bill: bill);

    // Load bundled Cairo font for Arabic + English support
    final fontData = await rootBundle.load('fonts/Cairo-Regular.ttf');
    final fontBoldData = await rootBundle.load('fonts/Cairo-Bold.ttf');
    final font = pw.Font.ttf(fontData);
    final fontBold = pw.Font.ttf(fontBoldData);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll80,
        margin: const pw.EdgeInsets.all(8),
        theme: pw.ThemeData.withFont(base: font, bold: fontBold),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
          children: [
            _buildHeader(invoice),
            pw.SizedBox(height: 8),
            pw.Divider(),
            pw.SizedBox(height: 8),
            _buildItemsTable(items),
            pw.SizedBox(height: 8),
            pw.Divider(thickness: 2),
            pw.SizedBox(height: 8),
            _buildTotal(
              invoice.totalAmount,
              invoice.discountAmount,
              invoice.discountPercentage,
            ),
            pw.SizedBox(height: 16),
            _buildFooter(),
          ],
        ),
      ),
    );

    return pdf.save();
  }

  List<InvoiceItem> _buildInvoiceItems({
    required List<Order> orders,
    required SessionBill bill,
  }) {
    final items = <InvoiceItem>[];

    // Add time duration as first item
    if (bill.timeCost > 0) {
      items.add(
        InvoiceItem.timeDuration(
          durationFormatted: _formatDuration(bill.duration),
          totalCost: bill.timeCost,
        ),
      );
    }

    // Add product orders
    for (final order in orders) {
      items.add(
        InvoiceItem(
          name: order.product?.name ?? 'Product #${order.productId}',
          quantity: order.quantity,
          unitPrice: order.unitPrice,
          totalPrice: order.totalPrice,
        ),
      );
    }

    return items;
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  pw.Widget _buildHeader(Invoice invoice) {
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    final issuedDate = invoice.issuedAt ?? DateTime.now();

    return pw.Column(
      children: [
        pw.Text(
          invoice.shopName,
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
          textAlign: pw.TextAlign.center,
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          dateFormat.format(issuedDate),
          style: const pw.TextStyle(fontSize: 10),
          textAlign: pw.TextAlign.center,
        ),
        pw.SizedBox(height: 2),
        pw.Text(
          'Invoice #: ${invoice.invoiceNumber}',
          style: const pw.TextStyle(fontSize: 10),
          textAlign: pw.TextAlign.center,
        ),
        if (invoice.customerName != null &&
            invoice.customerName!.trim().isNotEmpty) ...[
          pw.SizedBox(height: 4),
          pw.Text(
            'Customer: ${invoice.customerName}',
            style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
            textAlign: pw.TextAlign.center,
          ),
        ],
      ],
    );
  }

  pw.Widget _buildItemsTable(List<InvoiceItem> items) {
    return pw.Table(
      columnWidths: {
        0: const pw.FlexColumnWidth(3),
        1: const pw.FlexColumnWidth(1),
        2: const pw.FlexColumnWidth(1.5),
      },
      children: [
        // Header row
        pw.TableRow(
          children: [
            pw.Text(
              'Item',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9),
            ),
            pw.Text(
              'Qty',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9),
              textAlign: pw.TextAlign.center,
            ),
            pw.Text(
              'Amount',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9),
              textAlign: pw.TextAlign.right,
            ),
          ],
        ),
        // Item rows
        ...items.map(
          (item) => pw.TableRow(
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 2),
                child: pw.Text(
                  item.name,
                  style: const pw.TextStyle(fontSize: 9),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 2),
                child: pw.Text(
                  '${item.quantity}',
                  style: const pw.TextStyle(fontSize: 9),
                  textAlign: pw.TextAlign.center,
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 2),
                child: pw.Text(
                  item.totalPrice.toStringAsFixed(2),
                  style: const pw.TextStyle(fontSize: 9),
                  textAlign: pw.TextAlign.right,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _buildTotal(
    double totalAmount,
    double discountAmount,
    double discountPercentage,
  ) {
    // If no discount, show just the total
    if (discountAmount <= 0) {
      return pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'TOTAL:',
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
          ),
          pw.Text(
            '${totalAmount.toStringAsFixed(2)} EGP',
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
          ),
        ],
      );
    }

    // If there is a discount, show Subtotal, Discount, then Total
    final subtotal = totalAmount + discountAmount;

    return pw.Column(
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Subtotal:', style: const pw.TextStyle(fontSize: 10)),
            pw.Text(
              '${subtotal.toStringAsFixed(2)} EGP',
              style: const pw.TextStyle(fontSize: 10),
            ),
          ],
        ),
        pw.SizedBox(height: 2),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'Discount (${discountPercentage.toStringAsFixed(0)}%):',
              style: const pw.TextStyle(fontSize: 10),
            ),
            pw.Text(
              '-${discountAmount.toStringAsFixed(2)} EGP',
              style: const pw.TextStyle(fontSize: 10),
            ),
          ],
        ),
        pw.SizedBox(height: 4),
        pw.Divider(),
        pw.SizedBox(height: 4),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'TOTAL:',
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
            ),
            pw.Text(
              '${totalAmount.toStringAsFixed(2)} EGP',
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildFooter() {
    return pw.Column(
      children: [
        pw.Text(
          'Thank you!',
          style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
          textAlign: pw.TextAlign.center,
        ),
        pw.Text(
          'Visit again',
          style: const pw.TextStyle(fontSize: 10),
          textAlign: pw.TextAlign.center,
        ),
      ],
    );
  }
}
