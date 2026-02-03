import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/reports_repository.dart';
import '../domain/daily_revenue_report.dart';
import '../domain/product_performance_report.dart';
import '../domain/room_usage_report.dart';
import '../domain/room_financial_report.dart';

part 'reports_providers.g.dart';

@riverpod
class ReportsDateRange extends _$ReportsDateRange {
  @override
  DateTimeRange build() {
    final end = DateTime.now();
    final start = end.subtract(const Duration(days: 7));
    return DateTimeRange(start: start, end: end);
  }

  void setRange(DateTimeRange range) {
    state = range;
  }
}

@riverpod
Future<List<DailyRevenueReport>> dailyRevenue(DailyRevenueRef ref) async {
  final repository = ref.watch(reportsRepositoryProvider);
  final range = ref.watch(reportsDateRangeProvider);
  return repository.fetchRevenue(range.start, range.end);
}

@riverpod
Future<List<ProductPerformanceReport>> topProducts(TopProductsRef ref) async {
  final repository = ref.watch(reportsRepositoryProvider);
  final range = ref.watch(reportsDateRangeProvider);
  return repository.fetchTopProducts(start: range.start, end: range.end);
}

@riverpod
Future<List<RoomUsageReport>> roomUsage(Ref ref) async {
  final repository = ref.watch(reportsRepositoryProvider);
  final range = ref.watch(reportsDateRangeProvider);
  return repository.fetchRoomUsage(start: range.start, end: range.end);
}

@riverpod
Future<List<RoomFinancialReport>> roomFinancials(Ref ref) async {
  final repository = ref.watch(reportsRepositoryProvider);
  final range = ref.watch(reportsDateRangeProvider);
  return repository.fetchRoomFinancials(start: range.start, end: range.end);
}
