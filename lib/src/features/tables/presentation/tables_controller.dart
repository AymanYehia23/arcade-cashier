import 'package:arcade_cashier/src/features/tables/data/tables_repository.dart';
import 'package:arcade_cashier/src/features/tables/domain/cafe_table.dart';
import 'package:arcade_cashier/src/features/tables/domain/table_with_session.dart';
import 'package:arcade_cashier/src/features/sessions/data/sessions_repository.dart';
import 'package:arcade_cashier/src/features/sessions/domain/session.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';

part 'tables_controller.g.dart';

@riverpod
class TablesController extends _$TablesController {
  @override
  FutureOr<void> build() {
    // DB triggers handle table status updates automatically
  }

  Future<void> createTable({
    required String name,
    int? tableNumber,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(tablesRepositoryProvider);
      await repository.createTable(name: name, tableNumber: tableNumber);
    });
  }

  Future<void> updateTableDetails({
    required int tableId,
    required String name,
    int? tableNumber,
    required TableStatus status,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(tablesRepositoryProvider);
      await repository.updateTableDetails(
        tableId: tableId,
        name: name,
        tableNumber: tableNumber,
        status: status,
      );
    });
  }

  Future<void> deleteTable(int tableId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(tablesRepositoryProvider);
      await repository.deleteTable(tableId);
    });
  }
}

@riverpod
Stream<List<TableWithSession>> tablesWithSessions(Ref ref) {
  final tablesRepo = ref.watch(tablesRepositoryProvider);
  final sessionsRepo = ref.watch(sessionsRepositoryProvider);

  return Rx.combineLatest2<List<CafeTable>, List<Session>,
      List<TableWithSession>>(
    tablesRepo.watchTables(),
    sessionsRepo.watchActiveSessions(),
    (tables, sessions) {
      return tables.map((table) {
        final activeSession = sessions.firstWhereOrNull(
          (s) => s.tableId == table.id && s.status == SessionStatus.active,
        );
        return TableWithSession(table: table, activeSession: activeSession);
      }).toList();
    },
  );
}
