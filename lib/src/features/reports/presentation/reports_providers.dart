import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/reports_repository.dart';
import '../domain/daily_revenue_report.dart';
import '../domain/product_performance_report.dart';
import '../domain/room_usage_report.dart';

part 'reports_providers.g.dart';

@riverpod
class DateRangeFilter extends _$DateRangeFilter {
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
  final range = ref.watch(dateRangeFilterProvider);
  return repository.fetchRevenue(range.start, range.end);
}

@riverpod
Future<List<ProductPerformanceReport>> topProducts(TopProductsRef ref) async {
  final repository = ref.watch(reportsRepositoryProvider);
  final range = ref.watch(dateRangeFilterProvider);
  return repository.fetchTopProducts(start: range.start, end: range.end);
}

@riverpod
Future<List<RoomUsageReport>> roomUsage(RoomUsageRef ref) async {
  final repository = ref.watch(reportsRepositoryProvider);
  final range = ref.watch(dateRangeFilterProvider);
  return repository.fetchRoomUsage(start: range.start, end: range.end);
}
