import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'reports_providers.dart';
import 'tabs/revenue_tab.dart';
import 'tabs/products_tab.dart';
import 'tabs/rooms_tab.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reports & Analytics'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Revenue', icon: Icon(Icons.bar_chart)),
              Tab(text: 'Products', icon: Icon(Icons.shopping_cart)),
              Tab(text: 'Room Usage', icon: Icon(Icons.pie_chart)),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () async {
                final currentRange = ref.read(dateRangeFilterProvider);
                final picked = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                  initialDateRange: currentRange,
                );
                if (picked != null) {
                  ref.read(dateRangeFilterProvider.notifier).setRange(picked);
                }
              },
            ),
          ],
        ),
        body: const TabBarView(
          children: [RevenueTab(), ProductsTab(), RoomsTab()],
        ),
      ),
    );
  }
}
