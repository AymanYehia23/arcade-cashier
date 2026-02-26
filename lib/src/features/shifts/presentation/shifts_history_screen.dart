import 'package:arcade_cashier/src/common_widgets/logo_loading_indicator.dart';
import 'package:arcade_cashier/src/features/shifts/data/shift_repository.dart';
import 'package:arcade_cashier/src/features/shifts/domain/shift_report_summary.dart';
import 'package:arcade_cashier/src/constants/app_routes.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ShiftsHistoryScreen extends ConsumerWidget {
  const ShiftsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportsAsync = ref.watch(shiftReportsProvider);
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.shiftReports),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(shiftReportsProvider),
          ),
        ],
      ),
      body: reportsAsync.when(
        loading: () => const Center(child: LogoLoadingIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                loc.failedToLoadShiftReports,
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () => ref.invalidate(shiftReportsProvider),
                icon: const Icon(Icons.refresh),
                label: Text(loc.retry),
              ),
            ],
          ),
        ),
        data: (reports) {
          if (reports.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.assignment_outlined,
                    size: 64,
                    color: theme.colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    loc.noShiftReportsYet,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: reports.length,
            itemBuilder: (context, index) {
              final report = reports[index];
              return _ShiftReportCard(report: report);
            },
          );
        },
      ),
    );
  }
}

class _ShiftReportCard extends StatelessWidget {
  const _ShiftReportCard({required this.report});

  final ShiftReportSummary report;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;
    final dateFormat = DateFormat('dd/MM/yyyy – HH:mm');
    final openedDate = report.openedAt != null
        ? dateFormat.format(report.openedAt!)
        : '—';

    final isNegativeVariance = report.variance < 0;
    final varianceColor = isNegativeVariance
        ? Colors.red.shade600
        : Colors.green.shade600;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          context.push(AppRoutes.shiftDetails, extra: report);
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date & Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        openedDate,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
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
              const SizedBox(height: 12),
              // Cashier name
              Row(
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 18,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    report.cashierName ?? loc.unknown,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Revenue & Variance
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Total Revenue
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loc.totalRevenue,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${report.totalRevenue.toStringAsFixed(2)} ${loc.egp}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  // Variance
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        loc.variance,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isNegativeVariance
                                ? Icons.trending_down
                                : Icons.trending_up,
                            size: 18,
                            color: varianceColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${report.variance.toStringAsFixed(2)} ${loc.egp}',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: varianceColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
