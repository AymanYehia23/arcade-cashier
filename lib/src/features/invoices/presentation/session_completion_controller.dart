import 'dart:typed_data';

import 'package:arcade_cashier/src/features/billing/domain/session_bill.dart';
import 'package:arcade_cashier/src/features/invoices/application/pdf_invoice_service.dart';
import 'package:arcade_cashier/src/features/invoices/data/invoices_repository.dart';
import 'package:arcade_cashier/src/features/invoices/domain/invoice.dart';
import 'package:arcade_cashier/src/features/invoices/presentation/invoices_search_controller.dart';
import 'package:arcade_cashier/src/features/orders/domain/order.dart';
import 'package:arcade_cashier/src/features/rooms/data/rooms_repository.dart';
import 'package:arcade_cashier/src/features/sessions/data/sessions_repository.dart';
import 'package:arcade_cashier/src/features/sessions/domain/session.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_completion_controller.g.dart';

/// Result of session completion containing the generated PDF and invoice.
class SessionCompletionResult {
  final Uint8List pdfBytes;
  final Invoice invoice;

  SessionCompletionResult({required this.pdfBytes, required this.invoice});
}

@riverpod
class SessionCompletionController extends _$SessionCompletionController {
  @override
  FutureOr<SessionCompletionResult?> build() {
    return null;
  }

  /// Completes a session, creates an invoice, and generates the PDF.
  Future<SessionCompletionResult?> completeSession({
    required Session session,
    int? roomId,
    required List<Order> orders,
    required SessionBill bill,
    String shopName = 'Arcade',
  }) async {
    state = const AsyncLoading();

    try {
      // 1. Stop the session in DB
      await ref
          .read(sessionsRepositoryProvider)
          .stopSession(sessionId: session.id, roomId: roomId);

      // Invalidate rooms to refresh UI (only if room was involved)
      if (roomId != null) {
        ref.invalidate(roomsValuesProvider);
      }

      // 2. Generate invoice number
      final invoiceNumber = await ref
          .read(invoicesRepositoryProvider)
          .generateInvoiceNumber();

      // 3. Create invoice record
      final invoice = Invoice(
        sessionId: session.id,
        invoiceNumber: invoiceNumber,
        shopName: shopName,
        totalAmount: bill.totalAmount,
        paymentMethod: 'cash',
        issuedAt: DateTime.now(),
      );

      final createdInvoice = await ref
          .read(invoicesRepositoryProvider)
          .createInvoice(invoice);

      // Invalidate history to ensure it updates (in case Realtime is off)
      ref.invalidate(invoicesPaginationProvider);

      // 4. Generate PDF
      // Calculate the actual session duration before generating PDF
      final endTimeUtc = DateTime.now().toUtc();
      final sessionWithEndTime = session.copyWith(endTime: endTimeUtc);

      final pdfService = PdfInvoiceService();
      final pdfBytes = await pdfService.generateInvoicePdf(
        invoice: createdInvoice,
        session: sessionWithEndTime,
        orders: orders,
        bill: bill,
      );

      final result = SessionCompletionResult(
        pdfBytes: pdfBytes,
        invoice: createdInvoice,
      );

      state = AsyncData(result);
      return result;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
  }
}
