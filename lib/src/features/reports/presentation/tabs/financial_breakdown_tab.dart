import 'package:arcade_cashier/src/common_widgets/error_state_widget.dart';
import 'package:arcade_cashier/src/common_widgets/logo_loading_indicator.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:arcade_cashier/src/utils/error_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../reports_providers.dart';

String _translateSourceName(String sourceName, AppLocalizations l10n) {
  // Normalize the source name for comparison
  final normalized = sourceName.toLowerCase().trim();

  // Check for device types
  if (sourceName == 'PlayStation 4') return l10n.playstation4;
  if (sourceName == 'PlayStation 5') return l10n.playstation5;

  // Check for walk-in variations
  if (normalized.contains('walk') && normalized.contains('in')) {
    return l10n.walkIn;
  }

  // Check for quick order variations
  if (normalized.contains('quick') && normalized.contains('order')) {
    return l10n.quickOrder;
  }

  // Check for unknown
  if (normalized == 'unknown') return l10n.unknown;

  // Return original if no match found
  return sourceName;
}

class FinancialBreakdownTab extends ConsumerWidget {
  const FinancialBreakdownTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final financialsAsync = ref.watch(roomFinancialsProvider);
    final currencyFormat = NumberFormat.currency(
      symbol: '${loc.egp} ',
      decimalDigits: 0,
    );

    return financialsAsync.when(
      data: (report) {
        if (report.isEmpty) {
          return Center(child: Text(loc.noDataPeriod));
        }

        final double grandTotalRevenue = report.fold(
          0,
          (sum, item) => sum + item.totalRevenue,
        );

        return LayoutBuilder(
          builder: (context, constraints) {
            // Use card layout on mobile, table on larger screens
            final isMobile = constraints.maxWidth < 600;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    loc.profitabilityBySource,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  if (isMobile)
                  // Mobile: Card-based layout
                  ...[
                    ...report.map(
                      (item) => _FinancialCard(
                        item: item,
                        currencyFormat: currencyFormat,
                        loc: loc,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              loc.grandTotalRevenue,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              currencyFormat.format(grandTotalRevenue),
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ] else
                    // Desktop/Tablet: Table layout
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                columns: [
                                  DataColumn(label: Text(loc.tableSource)),
                                  DataColumn(
                                    label: Text(loc.tableSessions),
                                    numeric: true,
                                  ),
                                  DataColumn(
                                    label: Text(loc.tableHours),
                                    numeric: true,
                                  ),
                                  DataColumn(
                                    label: Text(loc.tableRevenue),
                                    numeric: true,
                                  ),
                                  DataColumn(
                                    label: Text(loc.avgTicket),
                                    numeric: true,
                                  ),
                                ],
                                rows: report.map((item) {
                                  return DataRow(
                                    cells: [
                                      DataCell(
                                        Text(
                                          _translateSourceName(
                                            item.sourceName,
                                            loc,
                                          ),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Text(item.totalSessions.toString()),
                                      ),
                                      DataCell(
                                        Text(
                                          item.totalHours.toStringAsFixed(1),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          currencyFormat.format(
                                            item.totalRevenue,
                                          ),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          currencyFormat.format(item.avgTicket),
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                            const Divider(),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 16.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    loc.grandTotalRevenue,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                  Text(
                                    currencyFormat.format(grandTotalRevenue),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
      loading: () => const Center(child: LogoLoadingIndicator()),
      error: (err, stack) => ErrorStateWidget(
        message: getUserFriendlyErrorMessage(err, context),
        onRetry: () => ref.invalidate(roomFinancialsProvider),
      ),
    );
  }
}

class _FinancialCard extends StatelessWidget {
  final dynamic item;
  final NumberFormat currencyFormat;
  final AppLocalizations loc;

  const _FinancialCard({
    required this.item,
    required this.currencyFormat,
    required this.loc,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Source name as header
            Text(
              _translateSourceName(item.sourceName, loc),
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            // Stats in a grid
            Row(
              children: [
                Expanded(
                  child: _StatItem(
                    label: loc.tableSessions,
                    value: item.totalSessions.toString(),
                  ),
                ),
                Expanded(
                  child: _StatItem(
                    label: loc.tableHours,
                    value:
                        '${item.totalHours.toStringAsFixed(1)} ${loc.hoursAbbr}',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _StatItem(
                    label: loc.tableRevenue,
                    value: currencyFormat.format(item.totalRevenue),
                    isHighlight: true,
                  ),
                ),
                Expanded(
                  child: _StatItem(
                    label: loc.avgTicket,
                    value: currencyFormat.format(item.avgTicket),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isHighlight;

  const _StatItem({
    required this.label,
    required this.value,
    this.isHighlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
