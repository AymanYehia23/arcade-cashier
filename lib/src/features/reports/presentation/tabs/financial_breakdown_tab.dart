import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../reports_providers.dart';

class FinancialBreakdownTab extends ConsumerWidget {
  const FinancialBreakdownTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final financialsAsync = ref.watch(roomFinancialsProvider);
    final currencyFormat = NumberFormat.currency(
      symbol: 'EGP ',
      decimalDigits: 0,
    );

    return financialsAsync.when(
      data: (report) {
        if (report.isEmpty) {
          return const Center(
            child: Text("No data available for this period."),
          );
        }

        final double grandTotalRevenue = report.fold(
          0,
          (sum, item) => sum + item.totalRevenue,
        );

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Profitability by Source",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('Source')),
                            DataColumn(label: Text('Sessions'), numeric: true),
                            DataColumn(label: Text('Hours'), numeric: true),
                            DataColumn(label: Text('Revenue'), numeric: true),
                            DataColumn(
                              label: Text('Avg. Ticket'),
                              numeric: true,
                            ),
                          ],
                          rows: report.map((item) {
                            return DataRow(
                              cells: [
                                DataCell(
                                  Text(
                                    item.sourceName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataCell(Text(item.totalSessions.toString())),
                                DataCell(
                                  Text(item.totalHours.toStringAsFixed(1)),
                                ),
                                DataCell(
                                  Text(
                                    currencyFormat.format(item.totalRevenue),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(currencyFormat.format(item.avgTicket)),
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
                              "Grand Total Revenue: ",
                              style: Theme.of(context).textTheme.titleMedium,
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}
