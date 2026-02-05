import 'package:arcade_cashier/src/features/billing/domain/session_bill.dart';
import 'package:arcade_cashier/src/features/invoices/domain/invoice.dart';
import 'package:arcade_cashier/src/features/invoices/domain/invoice_item.dart';
import 'package:arcade_cashier/src/features/orders/domain/order.dart';
import 'package:arcade_cashier/src/features/reports/domain/shift_report.dart';
import 'package:arcade_cashier/src/features/sessions/domain/session.dart';
import 'package:arcade_cashier/src/features/settings/data/printer_repository.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pdf_invoice_service.g.dart';

@riverpod
PdfInvoiceService pdfInvoiceService(Ref ref) {
  return PdfInvoiceService(ref);
}

/// Service for generating invoice PDFs optimized for thermal printers.
class PdfInvoiceService {
  final Ref _ref;

  PdfInvoiceService(this._ref);

  /// Generates invoice PDF and handles printing (silent if default set, else dialog).
  Future<Uint8List> printInvoice({
    required Invoice invoice,
    required Session session,
    required List<Order> orders,
    required SessionBill bill,
    required AppLocalizations loc,
  }) async {
    final pdfBytes = await generateInvoicePdf(
      invoice: invoice,
      session: session,
      orders: orders,
      bill: bill,
      loc: loc,
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
    required AppLocalizations loc,
  }) async {
    final pdf = pw.Document();

    // Build invoice items list
    final items = _buildInvoiceItems(orders: orders, bill: bill, loc: loc);

    // Load bundled Cairo font for Arabic + English support
    final fontData = await rootBundle.load('fonts/Cairo-Regular.ttf');
    final fontBoldData = await rootBundle.load('fonts/Cairo-Bold.ttf');
    final font = pw.Font.ttf(fontData);
    final fontBold = pw.Font.ttf(fontBoldData);

    // Ensure Arabic text direction is handled implicitly by the font/renderer or explicitly if needed.
    // pdf package's textDirection depends on ThemeData.
    final textDirection = loc.localeName == 'ar'
        ? pw.TextDirection.rtl
        : pw.TextDirection.ltr;

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll80,
        margin: const pw.EdgeInsets.all(8),
        theme: pw.ThemeData.withFont(base: font, bold: fontBold),
        textDirection: textDirection,
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
          children: [
            _buildHeader(invoice, loc),
            pw.SizedBox(height: 8),
            pw.Divider(),
            pw.SizedBox(height: 8),
            _buildItemsTable(items, loc),
            pw.SizedBox(height: 8),
            pw.Divider(thickness: 2),
            pw.SizedBox(height: 8),
            _buildTotal(
              invoice.totalAmount,
              invoice.discountAmount,
              invoice.discountPercentage,
              loc,
            ),
            pw.SizedBox(height: 16),
            _buildFooter(loc),
          ],
        ),
      ),
    );

    return pdf.save();
  }

  List<InvoiceItem> _buildInvoiceItems({
    required List<Order> orders,
    required SessionBill bill,
    required AppLocalizations loc,
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
          name: order.product?.name ?? '${loc.tableItem} #${order.productId}',
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

  pw.Widget _buildHeader(Invoice invoice, AppLocalizations loc) {
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    final issuedDate = invoice.issuedAt ?? DateTime.now();

    return pw.Column(
      children: [
        pw.Text(
          loc.brandName,
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
          '${loc.invoiceNum}: ${invoice.invoiceNumber}',
          style: const pw.TextStyle(fontSize: 10),
          textAlign: pw.TextAlign.center,
        ),
        if (invoice.customerName != null &&
            invoice.customerName!.trim().isNotEmpty) ...[
          pw.SizedBox(height: 4),
          pw.Text(
            '${loc.customer}: ${invoice.customerName}',
            style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
            textAlign: pw.TextAlign.center,
          ),
        ],
      ],
    );
  }

  pw.Widget _buildItemsTable(List<InvoiceItem> items, AppLocalizations loc) {
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
              loc.tableItem,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9),
            ),
            pw.Text(
              loc.tableQty,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9),
              textAlign: pw.TextAlign.center,
            ),
            pw.Text(
              loc.tableAmount,
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
    AppLocalizations loc,
  ) {
    // If no discount, show just the total
    if (discountAmount <= 0) {
      return pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            '${loc.totalLabel}:',
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
          ),
          pw.Text(
            '${totalAmount.toStringAsFixed(2)} ${loc.egp}',
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
            pw.Text(
              '${loc.subtotalLabel}:',
              style: const pw.TextStyle(fontSize: 10),
            ),
            pw.Text(
              '${subtotal.toStringAsFixed(2)} ${loc.egp}',
              style: const pw.TextStyle(fontSize: 10),
            ),
          ],
        ),
        pw.SizedBox(height: 2),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              '${loc.discountLabelPdf} (${discountPercentage.toStringAsFixed(0)}%):',
              style: const pw.TextStyle(fontSize: 10),
            ),
            pw.Text(
              '-${discountAmount.toStringAsFixed(2)} ${loc.egp}',
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
              '${loc.totalLabel}:',
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
            ),
            pw.Text(
              '${totalAmount.toStringAsFixed(2)} ${loc.egp}',
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  /// Generates a Z-Report (Shift Report) PDF optimized for 80mm thermal printer roll.
  Future<Uint8List> generateShiftReportPdf(
    ShiftReport report,
    AppLocalizations loc,
  ) async {
    final pdf = pw.Document();

    // Load bundled Cairo font for Arabic + English support
    final fontData = await rootBundle.load('fonts/Cairo-Regular.ttf');
    final fontBoldData = await rootBundle.load('fonts/Cairo-Bold.ttf');
    final font = pw.Font.ttf(fontData);
    final fontBold = pw.Font.ttf(fontBoldData);

    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    final generatedDate = report.generatedAt ?? DateTime.now();

    final textDirection = loc.localeName == 'ar'
        ? pw.TextDirection.rtl
        : pw.TextDirection.ltr;

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll80,
        margin: const pw.EdgeInsets.all(8),
        theme: pw.ThemeData.withFont(base: font, bold: fontBold),
        textDirection: textDirection,
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
          children: [
            // Header
            pw.Text(
              loc.zReportTitle,
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              textAlign: pw.TextAlign.center,
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              loc.brandName,
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
              textAlign: pw.TextAlign.center,
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              dateFormat.format(generatedDate),
              style: const pw.TextStyle(fontSize: 10),
              textAlign: pw.TextAlign.center,
            ),
            pw.SizedBox(height: 8),
            pw.Divider(),
            pw.SizedBox(height: 8),

            // Body - Sales Breakdown
            _buildReportRow(loc.cashSales, report.totalCash, loc),
            pw.SizedBox(height: 4),
            _buildReportRow(loc.cardSales, report.totalCard, loc),
            pw.SizedBox(height: 4),
            _buildReportRow(
              loc.totalTransactions,
              report.transactionsCount.toDouble(),
              loc,
              isCount: true,
            ),

            pw.SizedBox(height: 8),
            pw.Divider(thickness: 2),
            pw.SizedBox(height: 8),

            // Totals
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  loc.netRevenue.toUpperCase(),
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  '${report.totalRevenue.toStringAsFixed(2)} ${loc.egp}',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),

            pw.SizedBox(height: 16),
            pw.Divider(),
            pw.SizedBox(height: 8),

            // Footer
            pw.Text(
              '${loc.discountsGiven}: ${report.totalDiscount.toStringAsFixed(2)} ${loc.egp}',
              style: const pw.TextStyle(fontSize: 9),
              textAlign: pw.TextAlign.center,
            ),
            pw.SizedBox(height: 16),
            pw.Text(
              '${loc.cashierSignature}: ______________',
              style: const pw.TextStyle(fontSize: 10),
              textAlign: pw.TextAlign.center,
            ),
          ],
        ),
      ),
    );

    return pdf.save();
  }

  pw.Widget _buildReportRow(
    String label,
    double value,
    AppLocalizations loc, {
    bool isCount = false,
  }) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(label, style: const pw.TextStyle(fontSize: 11)),
        pw.Text(
          isCount
              ? value.toInt().toString()
              : '${value.toStringAsFixed(2)} ${loc.egp}',
          style: const pw.TextStyle(fontSize: 11),
        ),
      ],
    );
  }

  pw.Widget _buildFooter(AppLocalizations loc) {
    return pw.Column(
      children: [
        pw.Text(
          loc.thankYou,
          style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
          textAlign: pw.TextAlign.center,
        ),
        pw.Text(
          loc.visitAgain,
          style: const pw.TextStyle(fontSize: 10),
          textAlign: pw.TextAlign.center,
        ),
      ],
    );
  }
}
