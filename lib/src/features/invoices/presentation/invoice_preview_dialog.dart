import 'dart:typed_data';

import 'package:arcade_cashier/src/features/invoices/data/invoices_repository.dart';
import 'package:arcade_cashier/src/features/invoices/domain/invoice.dart';
import 'package:arcade_cashier/src/features/invoices/presentation/invoices_search_controller.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';

/// Dialog that displays a PDF preview with print and save functionality.
class InvoicePreviewDialog extends ConsumerWidget {
  const InvoicePreviewDialog({
    super.key,
    required this.pdfBytes,
    required this.invoice,
  });

  final Uint8List pdfBytes;
  final Invoice invoice;

  Future<void> _voidInvoice(BuildContext context, WidgetRef ref) async {
    final loc = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Void Invoice'),
        content: const Text(
          'Are you sure you want to void this invoice? This will remove it from daily revenue.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(loc.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Void'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(); // Close preview dialog
      await ref.read(invoicesRepositoryProvider).cancelInvoice(invoice.id!);
      ref.invalidate(invoicesPaginationProvider);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: SizedBox(
        width: 400,
        height: 600,
        child: Column(
          children: [
            _DialogHeader(
              invoiceNumber: invoice.invoiceNumber,
              loc: loc,
              onClose: () => Navigator.of(context).pop(),
            ),
            Expanded(
              child: PdfPreview(
                build: (_) => pdfBytes,
                canChangePageFormat: false,
                canDebug: false,
                allowPrinting: true,
                allowSharing: true,
                pdfFileName: '${invoice.invoiceNumber}.pdf',
              ),
            ),
            if (!invoice.isCancelled)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
                    onPressed: () => _voidInvoice(context, ref),
                    icon: const Icon(Icons.block),
                    label: const Text('Void Invoice'),
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _DialogHeader extends StatelessWidget {
  const _DialogHeader({
    required this.invoiceNumber,
    required this.loc,
    required this.onClose,
  });

  final String invoiceNumber;
  final AppLocalizations loc;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${loc.invoiceNumber}: $invoiceNumber',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          IconButton(icon: const Icon(Icons.close), onPressed: onClose),
        ],
      ),
    );
  }
}
