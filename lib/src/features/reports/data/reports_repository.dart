import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/daily_revenue_report.dart';
import '../domain/product_performance_report.dart';
import '../domain/room_usage_report.dart';

part 'reports_repository.g.dart';

@Riverpod(keepAlive: true)
ReportsRepository reportsRepository(ReportsRepositoryRef ref) {
  return ReportsRepository(Supabase.instance.client);
}

class ReportsRepository {
  final SupabaseClient _supabase;

  ReportsRepository(this._supabase);

  Future<List<DailyRevenueReport>> fetchRevenue(
    DateTime start,
    DateTime end,
  ) async {
    final response = await _supabase
        .from('view_daily_revenue')
        .select()
        .gte('report_date', start.toIso8601String())
        .lte('report_date', end.toIso8601String())
        .order('report_date', ascending: true);

    return (response as List)
        .map((e) => DailyRevenueReport.fromJson(e))
        .toList();
  }

  Future<List<ProductPerformanceReport>> fetchTopProducts({
    DateTime? start,
    DateTime? end,
  }) async {
    // Note: View doesn't support date filtering yet.
    // If we wanted to filter by date, we'd need to change query or view.
    final response = await _supabase
        .from('view_top_products')
        .select()
        .limit(10);

    return (response as List)
        .map((e) => ProductPerformanceReport.fromJson(e))
        .toList();
  }

  Future<List<RoomUsageReport>> fetchRoomUsage({
    DateTime? start,
    DateTime? end,
  }) async {
    // Note: View doesn't support date filtering yet.
    final response = await _supabase.from('view_room_usage').select();

    return (response as List).map((e) => RoomUsageReport.fromJson(e)).toList();
  }
}
