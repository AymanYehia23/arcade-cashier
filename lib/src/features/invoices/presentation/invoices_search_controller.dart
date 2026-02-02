import 'package:arcade_cashier/src/features/invoices/data/invoices_repository.dart';
import 'package:arcade_cashier/src/features/invoices/domain/invoice.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'invoices_search_controller.g.dart';

@riverpod
class InvoiceDateRange extends _$InvoiceDateRange {
  @override
  DateTimeRange? build() {
    return null;
  }

  void setRange(DateTimeRange? range) {
    state = range;
  }
}

@riverpod
class InvoicesPagination extends _$InvoicesPagination {
  int _page = 0;
  final int _pageSize = 20;
  bool _hasMore = true;

  @override
  FutureOr<List<Invoice>> build() async {
    _page = 0;
    _hasMore = true;
    final dateRange = ref.watch(invoiceDateRangeProvider);
    return _fetchPage(page: 0, dateRange: dateRange);
  }

  Future<List<Invoice>> _fetchPage({
    required int page,
    DateTimeRange? dateRange,
  }) async {
    final repository = ref.read(invoicesRepositoryProvider);
    final invoices = await repository.fetchInvoices(
      startDate: dateRange?.start,
      endDate: dateRange?.end,
      page: page,
      pageSize: _pageSize,
    );

    if (invoices.length < _pageSize) {
      _hasMore = false;
    }
    return invoices;
  }

  Future<void> loadNextPage() async {
    if (!_hasMore || state.isLoading || state.hasError) return;

    state = const AsyncLoading<List<Invoice>>().copyWithPrevious(state);

    try {
      final dateRange = ref.read(invoiceDateRangeProvider);
      final nextVal = await _fetchPage(page: _page + 1, dateRange: dateRange);

      _page++;

      final currentList = state.valueOrNull ?? [];
      state = AsyncData([...currentList, ...nextVal]);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
