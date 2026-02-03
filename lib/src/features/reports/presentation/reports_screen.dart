import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'reports_providers.dart';
import 'tabs/revenue_tab.dart';
import 'tabs/products_tab.dart';
import 'tabs/rooms_tab.dart';
import 'tabs/financial_breakdown_tab.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateRange = ref.watch(reportsDateRangeProvider);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(title: const Text('Reports & Analytics')),
        body: Column(
          children: [
            // Filter Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Period: ${_formatDate(dateRange.start)} - ${_formatDate(dateRange.end)}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      ref.invalidate(dailyRevenueProvider);
                      ref.invalidate(topProductsProvider);
                      ref.invalidate(roomUsageProvider);
                      ref.invalidate(roomFinancialsProvider);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_month),
                    onPressed: () async {
                      final picked = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                        initialDateRange: dateRange,
                      );
                      if (picked != null) {
                        ref
                            .read(reportsDateRangeProvider.notifier)
                            .setRange(picked);
                      }
                    },
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // Tabs
            const TabBar(
              tabs: [
                Tab(text: 'Revenue', icon: Icon(Icons.bar_chart)),
                Tab(text: 'Financials', icon: Icon(Icons.attach_money)),
                Tab(text: 'Products', icon: Icon(Icons.shopping_cart)),
                Tab(text: 'Room Usage', icon: Icon(Icons.pie_chart)),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  RevenueTab(),
                  FinancialBreakdownTab(),
                  ProductsTab(),
                  RoomsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
