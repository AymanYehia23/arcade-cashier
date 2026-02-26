import 'package:arcade_cashier/src/constants/db_constants.dart';
import 'package:arcade_cashier/src/core/supabase_provider.dart';
import 'package:arcade_cashier/src/features/shifts/domain/cashier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'cashier_repository.g.dart';

class CashierRepository {
  final SupabaseClient _supabase;

  CashierRepository(this._supabase);

  /// Fetch all active cashiers.
  Future<List<Cashier>> fetchActiveCashiers() async {
    final data = await _supabase
        .from(DbTables.cashiers)
        .select()
        .eq('is_active', true)
        .order('name');

    return (data as List).map((e) => Cashier.fromJson(e)).toList();
  }

  /// Fetch all cashiers (including inactive) for admin management.
  Future<List<Cashier>> fetchAllCashiers() async {
    final data = await _supabase.from(DbTables.cashiers).select().order('name');

    return (data as List).map((e) => Cashier.fromJson(e)).toList();
  }

  /// Create a new cashier.
  Future<Cashier> createCashier(Cashier cashier) async {
    final data = await _supabase
        .from(DbTables.cashiers)
        .insert(cashier.toJson())
        .select()
        .single();

    return Cashier.fromJson(data);
  }

  /// Update an existing cashier.
  Future<Cashier> updateCashier(Cashier cashier) async {
    final data = await _supabase
        .from(DbTables.cashiers)
        .update({'name': cashier.name, 'pin_code': cashier.pinCode})
        .eq('id', cashier.id!)
        .select()
        .single();

    return Cashier.fromJson(data);
  }

  /// Soft-delete a cashier by setting is_active to false.
  Future<void> deactivateCashier(int id) async {
    await _supabase
        .from(DbTables.cashiers)
        .update({'is_active': false})
        .eq('id', id);
  }

  /// Reactivate a cashier.
  Future<void> reactivateCashier(int id) async {
    await _supabase
        .from(DbTables.cashiers)
        .update({'is_active': true})
        .eq('id', id);
  }
}

@Riverpod(keepAlive: true)
CashierRepository cashierRepository(Ref ref) {
  return CashierRepository(ref.watch(supabaseProvider));
}

@riverpod
Future<List<Cashier>> activeCashiers(Ref ref) {
  return ref.watch(cashierRepositoryProvider).fetchActiveCashiers();
}

@riverpod
Future<List<Cashier>> allCashiers(Ref ref) {
  return ref.watch(cashierRepositoryProvider).fetchAllCashiers();
}
