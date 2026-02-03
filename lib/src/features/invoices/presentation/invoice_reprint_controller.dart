import 'dart:typed_data';

import 'package:arcade_cashier/src/features/billing/domain/session_bill.dart';
import 'package:arcade_cashier/src/features/invoices/application/pdf_invoice_service.dart';
import 'package:arcade_cashier/src/features/invoices/data/invoices_repository.dart';
import 'package:arcade_cashier/src/features/invoices/presentation/invoice_preview_dialog.dart';
import 'package:arcade_cashier/src/features/orders/data/orders_repository.dart';
import 'package:arcade_cashier/src/features/sessions/data/sessions_repository.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'invoice_reprint_controller.g.dart';

@riverpod
class InvoiceReprintController extends _$InvoiceReprintController {
  @override
  FutureOr<void> build() {
    // Initial state is idle
  }

  Future<void> reprintInvoice(BuildContext context, int invoiceId) async {
    state = const AsyncLoading();

    try {
      // Fetch invoice
      final invoice = await ref
          .read(invoicesRepositoryProvider)
          .getInvoiceById(invoiceId);

      if (invoice == null) {
        state = AsyncError('Invoice not found', StackTrace.current);
        return;
      }

      // Fetch the actual session data from DB to get correct start/end times
      final session = await ref
          .read(sessionsRepositoryProvider)
          .getSessionById(invoice.sessionId);

      if (session == null) {
        state = AsyncError('Session not found', StackTrace.current);
        return;
      }

      // Fetch orders for this session
      final orders = await ref
          .read(ordersRepositoryProvider)
          .getOrdersForSession(invoice.sessionId);

      // Calculate orders total
      final ordersTotal = orders.fold(
        0.0,
        (sum, order) => sum + order.totalPrice,
      );

      // Time cost is total minus orders
      // Time cost is total minus orders
      final timeCost = invoice.totalAmount - ordersTotal;

      final bill = SessionBill(
        timeCost: timeCost,
        ordersTotal: ordersTotal,
        totalAmount: invoice.totalAmount,
        duration: session.endTime != null
            ? session.endTime!.difference(session.startTime)
            : Duration.zero,
      );

      final pdfService = ref.read(pdfInvoiceServiceProvider);
      final Uint8List pdfBytes = await pdfService.generateInvoicePdf(
        invoice: invoice,
        session: session,
        orders: orders,
        bill: bill,
        loc: AppLocalizations.of(context)!,
      );

      state = const AsyncData(null);

      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) =>
              InvoicePreviewDialog(pdfBytes: pdfBytes, invoice: invoice),
        );
      }
    } catch (e, st) {
      debugPrint('InvoiceReprintController error: $e');
      debugPrint('Stack trace: $st');
      state = AsyncError(e, st);
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error loading invoice: $e')));
      }
    }
  }
}
