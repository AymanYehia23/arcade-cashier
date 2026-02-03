import 'package:arcade_cashier/src/features/invoices/application/pdf_invoice_service.dart';
import 'package:arcade_cashier/src/features/reports/data/reports_repository.dart';
import 'package:arcade_cashier/src/features/reports/domain/shift_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';

/// Provider to fetch today's shift report.
final shiftReportProvider = FutureProvider<ShiftReport>((ref) async {
  final repo = ref.read(reportsRepositoryProvider);
  return repo.fetchShiftReport(DateTime.now());
});

class ShiftReportDialog extends ConsumerWidget {
  const ShiftReportDialog({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const ShiftReportDialog(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportAsync = ref.watch(shiftReportProvider);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: reportAsync.when(
            data: (report) => _buildContent(context, ref, report),
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(48.0),
                child: CircularProgressIndicator(),
              ),
            ),
            error: (error, stack) => _buildError(context, error),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    ShiftReport report,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'End of Shift Report',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Summary Cards
        _SummaryCard(
          title: 'Cash Sales',
          value: report.totalCash,
          icon: Icons.payments,
          color: Colors.green,
        ),
        const SizedBox(height: 12),
        _SummaryCard(
          title: 'Card Sales',
          value: report.totalCard,
          icon: Icons.credit_card,
          color: Colors.blue,
        ),
        const SizedBox(height: 12),
        _SummaryCard(
          title: 'Total Transactions',
          value: report.transactionsCount.toDouble(),
          icon: Icons.receipt_long,
          color: Colors.orange,
          isCount: true,
        ),
        const SizedBox(height: 16),

        const Divider(),
        const SizedBox(height: 16),

        // Total Revenue
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Net Revenue',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                '${report.totalRevenue.toStringAsFixed(2)} EGP',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // Discounts
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Discounts Given: ${report.totalDiscount.toStringAsFixed(2)} EGP',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ),

        const SizedBox(height: 24),

        // Print Button
        FilledButton.icon(
          onPressed: () => _printReport(context, ref, report),
          icon: const Icon(Icons.print),
          label: const Text('Print Z-Report'),
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildError(BuildContext context, Object error) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.error_outline, size: 48, color: Colors.red),
        const SizedBox(height: 16),
        Text(
          'Failed to load shift report',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          error.toString(),
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }

  Future<void> _printReport(
    BuildContext context,
    WidgetRef ref,
    ShiftReport report,
  ) async {
    final pdfService = ref.read(pdfInvoiceServiceProvider);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      final pdfBytes = await pdfService.generateShiftReportPdf(report);

      // Close the dialog BEFORE opening the print dialog.
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      await Printing.layoutPdf(
        onLayout: (format) async => pdfBytes,
        name: 'Z-Report-${DateTime.now().toIso8601String()}',
      );
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text('Failed to print report: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final double value;
  final IconData icon;
  final Color color;
  final bool isCount;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.isCount = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Text(
                  isCount
                      ? value.toInt().toString()
                      : '${value.toStringAsFixed(2)} EGP',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
