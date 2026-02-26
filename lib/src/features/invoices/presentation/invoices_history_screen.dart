import 'package:arcade_cashier/src/common_widgets/logo_loading_indicator.dart';
import 'package:arcade_cashier/src/features/invoices/presentation/invoices_search_controller.dart';
import 'package:arcade_cashier/src/features/invoices/presentation/widgets/date_filter_chips.dart';
import 'package:arcade_cashier/src/features/invoices/presentation/widgets/invoice_history_card.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:arcade_cashier/src/utils/error_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InvoicesHistoryScreen extends ConsumerStatefulWidget {
  const InvoicesHistoryScreen({super.key});

  @override
  ConsumerState<InvoicesHistoryScreen> createState() =>
      _InvoicesHistoryScreenState();
}

class _InvoicesHistoryScreenState extends ConsumerState<InvoicesHistoryScreen> {
  Future<void> _selectDateRange(BuildContext context) async {
    final currentRange = ref.read(invoiceDateRangeProvider);
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
      initialDateRange: currentRange,
    );

    if (picked != null) {
      ref.read(invoiceDateRangeProvider.notifier).setRange(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final invoicesState = ref.watch(invoicesPaginationProvider);
    final dateRange = ref.watch(invoiceDateRangeProvider);
    final isLoading = invoicesState.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.invoiceHistory),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.refresh(invoicesPaginationProvider),
          ),
          IconButton(
            icon: Icon(
              Icons.calendar_today,
              color: dateRange != null
                  ? Theme.of(context).colorScheme.primary
                  : null,
            ),
            onPressed: () => _selectDateRange(context),
          ),
          if (dateRange != null)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () =>
                  ref.read(invoiceDateRangeProvider.notifier).setRange(null),
            ),
        ],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoading &&
              scrollInfo.metrics.pixels >=
                  scrollInfo.metrics.maxScrollExtent - 500) {
            ref.read(invoicesPaginationProvider.notifier).loadNextPage();
          }
          return false;
        },
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: DateFilterChips()),
            if (invoicesState.valueOrNull?.isEmpty == true)
              SliverFillRemaining(
                child: Center(child: Text(loc.noInvoicesFound)),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final invoices = invoicesState.valueOrNull ?? [];
                  if (index >= invoices.length) return null;
                  return InvoiceHistoryCard(invoice: invoices[index]);
                }, childCount: invoicesState.valueOrNull?.length ?? 0),
              ),
            if (isLoading)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: LogoLoadingIndicator()),
                ),
              ),
            if (invoicesState.hasError && !invoicesState.isLoading)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      getUserFriendlyErrorMessage(
                        invoicesState.error!,
                        context,
                      ),
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
