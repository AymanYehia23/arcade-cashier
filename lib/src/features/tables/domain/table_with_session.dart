import 'package:arcade_cashier/src/features/tables/domain/cafe_table.dart';
import 'package:arcade_cashier/src/features/sessions/domain/session.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'table_with_session.freezed.dart';

/// Helper model combining table with its active session (mirrors RoomWithSession)
@freezed
class TableWithSession with _$TableWithSession {
  const factory TableWithSession({
    required CafeTable table,
    Session? activeSession,
  }) = _TableWithSession;
}
