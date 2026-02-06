import 'dart:typed_data';

import 'package:arcade_cashier/src/features/invoices/data/invoices_repository.dart';
import 'package:arcade_cashier/src/features/invoices/domain/invoice.dart';
import 'package:arcade_cashier/src/features/invoices/presentation/invoices_search_controller.dart';
import 'package:arcade_cashier/src/features/settings/data/printer_repository.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';

/// Dialog that displays a PDF preview with print and save functionality.
class InvoicePreviewDialog extends ConsumerStatefulWidget {
  const InvoicePreviewDialog({
    super.key,
    required this.pdfBytes,
    required this.invoice,
  });

  final Uint8List pdfBytes;
  final Invoice invoice;

  @override
  ConsumerState<InvoicePreviewDialog> createState() =>
      _InvoicePreviewDialogState();
}

class _InvoicePreviewDialogState extends ConsumerState<InvoicePreviewDialog> {
  bool _isPrinting = false;

  Future<void> _voidInvoice(BuildContext context) async {
    final loc = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(loc.voidInvoiceTitle),
        content: Text(loc.voidInvoiceConfirm),
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
            child: Text(loc.voidAction),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(); // Close preview dialog
      await ref
          .read(invoicesRepositoryProvider)
          .cancelInvoice(widget.invoice.id!);
      ref.invalidate(invoicesPaginationProvider);
    }
  }

  Future<void> _handlePrint() async {
    if (_isPrinting) return;
    final loc = AppLocalizations.of(context)!;

    setState(() {
      _isPrinting = true;
    });

    try {
      // Try to use default printer if set
      final printerRepo = ref.read(printerRepositoryProvider);
      final defaultPrinterUrl = await printerRepo.loadDefaultPrinter();
      Printer? targetPrinter;

      if (defaultPrinterUrl != null) {
        final printers = await Printing.listPrinters();
        try {
          targetPrinter = printers.firstWhere(
            (p) => p.url == defaultPrinterUrl,
          );
        } catch (_) {
          targetPrinter = null;
        }
      }

      if (targetPrinter != null) {
        // Direct print to saved printer
        await Printing.directPrintPdf(
          printer: targetPrinter,
          onLayout: (_) async => widget.pdfBytes,
          name: widget.invoice.invoiceNumber,
        );
      } else {
        // Fallback to system print dialog
        await Printing.layoutPdf(
          onLayout: (_) async => widget.pdfBytes,
          name: widget.invoice.invoiceNumber,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(loc.printFailed(e.toString()))));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isPrinting = false;
        });
      }
    }
  }

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
              invoiceNumber: widget.invoice.invoiceNumber,
              loc: loc,
              onClose: () => Navigator.of(context).pop(),
            ),
            Expanded(
              child: PdfPreview(
                build: (_) => widget.pdfBytes,
                canChangePageFormat: false,
                canDebug: false,
                allowPrinting: false,
                allowSharing: false,
                useActions: false,
                pdfFileName: '${widget.invoice.invoiceNumber}.pdf',
                loadingWidget: const SizedBox.shrink(),
                maxPageWidth: 400,
              ),
            ),
            // Custom action buttons
            Container(
              color: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: _isPrinting ? null : _handlePrint,
                    icon: _isPrinting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.print, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () async {
                      await Printing.sharePdf(
                        bytes: widget.pdfBytes,
                        filename: '${widget.invoice.invoiceNumber}.pdf',
                      );
                    },
                    icon: const Icon(Icons.share, color: Colors.white),
                  ),
                ],
              ),
            ),
            if (!widget.invoice.isCancelled)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
                    onPressed: () => _voidInvoice(context),
                    icon: const Icon(Icons.block),
                    label: Text(loc.voidInvoiceTitle),
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
