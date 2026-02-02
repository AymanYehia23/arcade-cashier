import 'dart:typed_data';

import 'package:arcade_cashier/src/features/invoices/domain/invoice.dart';
import 'package:arcade_cashier/src/features/invoices/domain/invoice_item.dart';
import 'package:arcade_cashier/src/features/orders/domain/order.dart';
import 'package:arcade_cashier/src/features/sessions/domain/session.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Service for generating invoice PDFs optimized for thermal printers.
class PdfInvoiceService {
  /// Generates a PDF invoice optimized for 80mm thermal printer roll.
  Future<Uint8List> generateInvoicePdf({
    required Invoice invoice,
    required Session session,
    required List<Order> orders,
    required double timeCost,
  }) async {
    final pdf = pw.Document();

    // Build invoice items list
    final items = _buildInvoiceItems(
      orders: orders,
      timeCost: timeCost,
      sessionDuration: _calculateDuration(session),
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll80,
        margin: const pw.EdgeInsets.all(8),
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
            _buildTotal(invoice.totalAmount),
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
    required double timeCost,
    required Duration sessionDuration,
  }) {
    final items = <InvoiceItem>[];

    // Add time duration as first item
    if (timeCost > 0) {
      items.add(
        InvoiceItem.timeDuration(
          durationFormatted: _formatDuration(sessionDuration),
          totalCost: timeCost,
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

  Duration _calculateDuration(Session session) {
    final endTime = session.endTime ?? DateTime.now();
    return endTime.difference(session.startTime);
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

  pw.Widget _buildTotal(double totalAmount) {
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
