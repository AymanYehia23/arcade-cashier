import 'package:arcade_cashier/src/constants/db_constants.dart';
import 'package:arcade_cashier/src/core/supabase_provider.dart';
import 'package:arcade_cashier/src/features/tables/domain/cafe_table.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'tables_repository.g.dart';

class TablesRepository {
  final SupabaseClient _supabase;

  TablesRepository(this._supabase);

  Future<List<CafeTable>> fetchTables() async {
    final data = await _supabase
        .from(DbTables.tables)
        .select()
        .order('table_number', ascending: true);
    return data.map((json) => CafeTable.fromJson(json)).toList();
  }


  Future<void> createTable({
    required String name,
    int? tableNumber,
    TableStatus status = TableStatus.available,
  }) async {
    await _supabase.from(DbTables.tables).insert({
      'name': name,
      'table_number': tableNumber,
      'current_status': status.name,
    });
  }

  Future<void> updateTableDetails({
    required int tableId,
    required String name,
    int? tableNumber,
    required TableStatus status,
  }) async {
    await _supabase
        .from(DbTables.tables)
        .update({
          'name': name,
          'table_number': tableNumber,
          'current_status': status.name,
        })
        .match({'id': tableId});
  }

  Future<void> deleteTable(int tableId) async {
    await _supabase.from(DbTables.tables).delete().match({'id': tableId});
  }

  Future<CafeTable> getTableById(int tableId) async {
    final data = await _supabase
        .from(DbTables.tables)
        .select()
        .eq('id', tableId)
        .single();
    return CafeTable.fromJson(data);
  }
}

@Riverpod(keepAlive: true)
TablesRepository tablesRepository(Ref ref) {
  return TablesRepository(ref.watch(supabaseProvider));
}

@riverpod
Future<List<CafeTable>> tablesValues(Ref ref) async {
  final repository = ref.watch(tablesRepositoryProvider);
  return repository.fetchTables();
}
