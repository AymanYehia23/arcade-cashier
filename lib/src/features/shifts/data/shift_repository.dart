import 'package:arcade_cashier/src/constants/db_constants.dart';
import 'package:arcade_cashier/src/core/supabase_provider.dart';
import 'package:arcade_cashier/src/features/invoices/domain/invoice.dart';
import 'package:arcade_cashier/src/features/shifts/domain/shift.dart';
import 'package:arcade_cashier/src/features/shifts/domain/shift_report_summary.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'shift_repository.g.dart';

class ShiftRepository {
  final SupabaseClient _supabase;

  ShiftRepository(this._supabase);

  /// Stream the currently open shift (if any).
  /// Joins with cashiers table to get the cashier name.
  Stream<Shift?> watchCurrentOpenShift() {
    return _supabase
        .from(DbTables.shifts)
        .stream(primaryKey: ['id'])
        .order('opened_at', ascending: false)
        .map((data) {
          final openShifts = data
              .where((row) => row['status'] == 'open')
              .toList();
          if (openShifts.isEmpty) return null;
          return Shift.fromJson(openShifts.first);
        });
  }

  /// One-shot fetch of the currently open shift with cashier name.
  Future<Shift?> getCurrentOpenShift() async {
    final data = await _supabase
        .from(DbTables.shifts)
        .select('*, cashiers(name)')
        .eq('status', 'open')
        .order('opened_at', ascending: false)
        .limit(1)
        .maybeSingle();

    if (data == null) return null;

    // Extract cashier name from joined data
    final cashierData = data['cashiers'] as Map<String, dynamic>?;
    final shiftData = Map<String, dynamic>.from(data);
    shiftData.remove('cashiers');
    shiftData['cashier_name'] = cashierData?['name'];

    return Shift.fromJson(shiftData);
  }

  /// Start a new shift for the given cashier.
  Future<Shift> startShift({
    required int cashierId,
    required double startingCash,
    required String cashierName,
  }) async {
    final data = await _supabase
        .from(DbTables.shifts)
        .insert({
          'cashier_id': cashierId,
          'status': 'open',
          'opened_at': DateTime.now().toUtc().toIso8601String(),
          'starting_cash': startingCash,
          'cashier_name': cashierName,
        })
        .select()
        .single();

    return Shift.fromJson(data);
  }

  /// End a shift by updating its status and recording cash data.
  Future<void> endShift({
    required int shiftId,
    required double actualEndingCash,
    required double cashDropped,
    required double cashLeftInDrawer,
  }) async {
    await _supabase
        .from(DbTables.shifts)
        .update({
          'status': 'closed',
          'actual_ending_cash': actualEndingCash,
          'cash_dropped': cashDropped,
          'cash_left_in_drawer': cashLeftInDrawer,
        })
        .eq('id', shiftId);
  }

  /// Fetch all shift reports from the shift_reports_summary view.
  Future<List<ShiftReportSummary>> fetchShiftReports() async {
    final data = await _supabase
        .from(DbTables.shiftReportsSummary)
        .select()
        .order('opened_at', ascending: false);

    return (data as List).map((e) => ShiftReportSummary.fromJson(e)).toList();
  }

  /// Fetch all invoices for a specific shift.
  Future<List<Invoice>> fetchInvoicesForShift(int shiftId) async {
    final data = await _supabase
        .from(DbTables.invoices)
        .select()
        .eq('shift_id', shiftId);

    return (data as List).map((e) => Invoice.fromJson(e)).toList();
  }
}

@Riverpod(keepAlive: true)
ShiftRepository shiftRepository(Ref ref) {
  return ShiftRepository(ref.watch(supabaseProvider));
}

/// The global source of truth for the current open shift.
/// Returns null when no shift is open — used for app lock routing.
@Riverpod(keepAlive: true)
Stream<Shift?> currentShift(Ref ref) {
  return ref.watch(shiftRepositoryProvider).watchCurrentOpenShift();
}

/// Fetches the list of all shift report summaries.
@riverpod
Future<List<ShiftReportSummary>> shiftReports(Ref ref) {
  return ref.watch(shiftRepositoryProvider).fetchShiftReports();
}

/// Fetches all invoices for a given shift ID.
@riverpod
Future<List<Invoice>> shiftInvoices(Ref ref, int shiftId) {
  return ref.watch(shiftRepositoryProvider).fetchInvoicesForShift(shiftId);
}
