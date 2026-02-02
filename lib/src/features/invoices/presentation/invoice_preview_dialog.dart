import 'dart:typed_data';

import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

/// Dialog that displays a PDF preview with print and save functionality.
class InvoicePreviewDialog extends StatelessWidget {
  const InvoicePreviewDialog({
    super.key,
    required this.pdfBytes,
    required this.invoiceNumber,
  });

  final Uint8List pdfBytes;
  final String invoiceNumber;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: SizedBox(
        width: 400,
        height: 600,
        child: Column(
          children: [
            _DialogHeader(
              invoiceNumber: invoiceNumber,
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
                pdfFileName: '$invoiceNumber.pdf',
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
