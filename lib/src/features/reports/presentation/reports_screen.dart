import 'package:arcade_cashier/src/common_widgets/logo_loading_indicator.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'reports_providers.dart';
import 'tabs/revenue_tab.dart';
import 'tabs/products_tab.dart';
import 'tabs/rooms_tab.dart';
import 'tabs/financial_breakdown_tab.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  bool _isRefreshing = false;

  Future<void> _handleRefresh() async {
    if (_isRefreshing) return;

    setState(() {
      _isRefreshing = true;
    });

    try {
      // Refresh all providers to force immediate refetch
      await Future.wait([
        ref.refresh(dailyRevenueProvider.future),
        ref.refresh(topProductsProvider.future),
        ref.refresh(roomUsageProvider.future),
        ref.refresh(roomFinancialsProvider.future),
      ]);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.dataRefreshed),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      // Handle errors silently - individual tabs will show their own errors
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.errorGeneric),
          duration: const Duration(seconds: 2),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isRefreshing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateRange = ref.watch(reportsDateRangeProvider);

    final loc = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(title: Text(loc.reportsTitle)),
        body: Column(
          children: [
            // Filter Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    loc.periodHeader(
                      _formatDate(dateRange.start, context),
                      _formatDate(dateRange.end, context),
                    ),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  IconButton(
                    icon: _isRefreshing
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: LogoLoadingIndicator(size: 20),
                          )
                        : const Icon(Icons.refresh),
                    onPressed: _isRefreshing ? null : _handleRefresh,
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
            TabBar(
              tabs: [
                Tab(text: loc.tabRevenue, icon: const Icon(Icons.bar_chart)),
                Tab(
                  text: loc.tabFinancials,
                  icon: const Icon(Icons.attach_money),
                ),
                Tab(
                  text: loc.tabProducts,
                  icon: const Icon(Icons.shopping_cart),
                ),
                Tab(text: loc.tabRoomUsage, icon: const Icon(Icons.pie_chart)),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: const [
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

  String _formatDate(DateTime date, BuildContext context) {
    return DateFormat.yMd(
      Localizations.localeOf(context).toString(),
    ).format(date);
  }
}
