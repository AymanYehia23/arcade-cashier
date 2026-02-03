import 'package:arcade_cashier/src/common_widgets/error_state_widget.dart';
import 'package:arcade_cashier/src/utils/error_messages.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../reports_providers.dart';

class RevenueTab extends ConsumerWidget {
  const RevenueTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final revenueAsync = ref.watch(dailyRevenueProvider);

    return revenueAsync.when(
      data: (data) {
        if (data.isEmpty) {
          return const Center(child: Text('No revenue data available.'));
        }

        final double totalWeekNetRevenue = data.fold(
          0,
          (sum, item) => sum + item.netRevenue,
        );
        final double totalWeekGrossRevenue = data.fold(
          0,
          (sum, item) => sum + item.grossRevenue,
        );
        final double totalWeekDiscount = data.fold(
          0,
          (sum, item) => sum + item.totalDiscount,
        );

        // Sort by date just in case
        final sortedData = List.of(data)
          ..sort((a, b) => a.date.compareTo(b.date));

        // Prepare bar groups
        final barGroups = sortedData.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: item.netRevenue,
                color: Colors.green, // Use Green for Net Revenue
                width: 16,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(4),
                ),
              ),
            ],
          );
        }).toList();

        final maxRevenue =
            sortedData
                .map((e) => e.netRevenue)
                .reduce((value, element) => value > element ? value : element) *
            1.2; // Add some buffer

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Summary Cards Row
              Row(
                children: [
                  Expanded(
                    child: _SummaryCard(
                      title: 'Gross Sales',
                      value: totalWeekGrossRevenue,
                      valueColor: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _SummaryCard(
                      title: 'Discounts',
                      value: -totalWeekDiscount,
                      valueColor: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _SummaryCard(
                      title: 'Net Revenue',
                      value: totalWeekNetRevenue,
                      valueColor: Colors.green.shade700,
                      isBold: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Expanded(
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: maxRevenue,
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipColor: (group) => Colors.blueGrey,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          final item = sortedData[group.x.toInt()];
                          return BarTooltipItem(
                            '${DateFormat('MM/dd').format(item.date)}\n',
                            const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: NumberFormat.currency(
                                  symbol: 'EGP',
                                ).format(rod.toY),
                                style: const TextStyle(
                                  color: Colors.yellow,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();
                            if (index >= 0 && index < sortedData.length) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  DateFormat(
                                    'E',
                                  ).format(sortedData[index].date),
                                  style: const TextStyle(fontSize: 12),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                          reservedSize: 30,
                        ),
                      ),
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: Colors.grey.withOpacity(0.2),
                        strokeWidth: 1,
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: barGroups,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => ErrorStateWidget(
        message: getUserFriendlyErrorMessage(err),
        onRetry: () => ref.invalidate(dailyRevenueProvider),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final double value;
  final Color valueColor;
  final bool isBold;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.valueColor,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Column(
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                NumberFormat.currency(symbol: 'EGP ').format(value),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
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
