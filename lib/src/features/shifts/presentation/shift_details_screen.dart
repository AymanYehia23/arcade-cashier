import 'package:arcade_cashier/src/common_widgets/logo_loading_indicator.dart';
import 'package:arcade_cashier/src/features/invoices/presentation/invoice_reprint_controller.dart';
import 'package:arcade_cashier/src/features/shifts/data/shift_repository.dart';
import 'package:arcade_cashier/src/features/shifts/domain/shift_report_summary.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ShiftDetailsScreen extends ConsumerWidget {
  const ShiftDetailsScreen({super.key, required this.report});

  final ShiftReportSummary report;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;
    final invoicesAsync = ref.watch(shiftInvoicesProvider(report.shiftId));
    final dateFormat = DateFormat('dd/MM/yyyy – HH:mm');
    final reprintState = ref.watch(invoiceReprintControllerProvider);

    final isNegativeVariance = report.variance < 0;
    final varianceColor = isNegativeVariance
        ? Colors.red.shade600
        : Colors.green.shade600;

    return Scaffold(
      appBar: AppBar(title: Text(loc.shiftNumber(report.shiftId))),
      body: CustomScrollView(
        slivers: [
          // ─── Shift Info Header ───
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: theme.colorScheme.primaryContainer,
                    child: Icon(
                      Icons.person,
                      color: theme.colorScheme.onPrimaryContainer,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          report.cashierName ?? loc.unknown,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          report.openedAt != null
                              ? dateFormat.format(report.openedAt!)
                              : '—',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: report.isClosed
                          ? theme.colorScheme.secondaryContainer
                          : theme.colorScheme.tertiaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      report.status.toUpperCase(),
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: report.isClosed
                            ? theme.colorScheme.onSecondaryContainer
                            : theme.colorScheme.onTertiaryContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 8)),

          // ─── Financial Summary — Compact Row of 4 ───
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _CompactStat(
                    label: loc.startingCash,
                    value: report.startingCash,
                    color: Colors.blue,
                    icon: Icons.account_balance_wallet,
                  ),
                  const SizedBox(width: 8),
                  _CompactStat(
                    label: loc.totalRevenue,
                    value: report.totalRevenue,
                    color: Colors.green,
                    icon: Icons.trending_up,
                  ),
                  const SizedBox(width: 8),
                  _CompactStat(
                    label: loc.cashDropped,
                    value: report.cashDropped,
                    color: Colors.orange,
                    icon: Icons.move_to_inbox,
                  ),
                  const SizedBox(width: 8),
                  _CompactStat(
                    label: loc.variance,
                    value: report.variance,
                    color: varianceColor,
                    icon: isNegativeVariance
                        ? Icons.warning_amber
                        : Icons.check_circle_outline,
                    valueColor: varianceColor,
                  ),
                ],
              ),
            ),
          ),

          // ─── Financial Details — Compact List ───
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: theme.colorScheme.outlineVariant),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  _DetailRow(
                    label: loc.cashRevenue,
                    value:
                        '${report.cashRevenue.toStringAsFixed(2)} ${loc.egp}',
                  ),
                  _divider(),
                  _DetailRow(
                    label: loc.digitalRevenue,
                    value:
                        '${report.digitalRevenue.toStringAsFixed(2)} ${loc.egp}',
                  ),
                  _divider(),
                  _DetailRow(
                    label: loc.expectedEndingCash,
                    value:
                        '${report.expectedEndingCash.toStringAsFixed(2)} ${loc.egp}',
                  ),
                  _divider(),
                  _DetailRow(
                    label: loc.actualEndingCash,
                    value:
                        '${(report.actualEndingCash ?? 0).toStringAsFixed(2)} ${loc.egp}',
                  ),
                  _divider(),
                  _DetailRow(
                    label: loc.cashLeftInDrawerLabel,
                    value:
                        '${report.cashLeftInDrawer.toStringAsFixed(2)} ${loc.egp}',
                  ),
                  if (report.notes != null && report.notes!.isNotEmpty) ...[
                    _divider(),
                    _DetailRow(label: loc.notes, value: report.notes!),
                  ],
                ],
              ),
            ),
          ),

          // ─── Invoices Header ───
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Text(
                loc.invoicesForShift,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // ─── Invoices List ───
          invoicesAsync.when(
            loading: () => const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: LogoLoadingIndicator()),
              ),
            ),
            error: (error, _) => SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Column(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      const SizedBox(height: 8),
                      Text('${loc.failedToLoadInvoices}: $error'),
                    ],
                  ),
                ),
              ),
            ),
            data: (invoices) {
              if (invoices.isEmpty) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.receipt_long,
                            size: 48,
                            color: theme.colorScheme.outline,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            loc.noInvoicesForShift,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.outline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final invoice = invoices[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 3,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      onTap: reprintState.isLoading
                          ? null
                          : () {
                              ref
                                  .read(
                                    invoiceReprintControllerProvider.notifier,
                                  )
                                  .reprintInvoice(context, invoice.id!);
                            },
                      leading: CircleAvatar(
                        radius: 18,
                        backgroundColor: theme.colorScheme.primaryContainer,
                        child: Icon(
                          invoice.paymentMethod.toLowerCase() == 'cash'
                              ? Icons.payments
                              : Icons.credit_card,
                          color: theme.colorScheme.onPrimaryContainer,
                          size: 18,
                        ),
                      ),
                      title: Text(
                        invoice.invoiceNumber,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        invoice.paymentMethod.toUpperCase(),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      trailing: Text(
                        '${invoice.totalAmount.toStringAsFixed(2)} ${loc.egp}',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  );
                }, childCount: invoices.length),
              );
            },
          ),

          // Bottom padding
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  static Widget _divider() =>
      Divider(height: 12, thickness: 0.5, color: Colors.grey.shade300);
}

// ─── Compact Stat Card ─────────────────────────────────

class _CompactStat extends StatelessWidget {
  const _CompactStat({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
    this.valueColor,
  });

  final String label;
  final double value;
  final Color color;
  final IconData icon;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '${value.toStringAsFixed(2)} ${loc.egp}',
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: valueColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Detail Row ─────────────────────────────────

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
