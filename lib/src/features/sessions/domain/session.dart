// ignore_for_file: invalid_annotation_target
import 'package:arcade_cashier/src/features/sessions/domain/match_type.dart';
import 'package:arcade_cashier/src/features/sessions/domain/session_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'session.freezed.dart';
part 'session.g.dart';

enum SessionStatus { active, paused, completed }

@freezed
class Session with _$Session {
  const Session._();

  const factory Session({
    required int id,
    @JsonKey(name: 'room_id') int? roomId,
    @JsonKey(name: 'table_id') int? tableId,
    @JsonKey(name: 'start_time') required DateTime startTime,
    @JsonKey(name: 'end_time') DateTime? endTime,
    @JsonKey(name: 'applied_hourly_rate') required double appliedHourlyRate,
    @JsonKey(name: 'is_multi_match') required bool isMultiMatch,
    @JsonKey(name: 'match_type')
    @Default(MatchType.single)
    MatchType matchType,
    @JsonKey(name: 'session_type')
    @Default(SessionType.open)
    SessionType sessionType,
    @JsonKey(name: 'planned_duration_minutes') int? plannedDurationMinutes,
    @Default('walk_in') String source,
    @Default(SessionStatus.active) SessionStatus status,
    @JsonKey(name: 'paused_at') DateTime? pausedAt,
    @JsonKey(name: 'total_paused_duration_seconds')
    @Default(0)
    int totalPausedDurationSeconds,
  }) = _Session;

  // Helper getters to determine session type
  bool get isRoomSession => roomId != null;
  bool get isTableSession => tableId != null;
  bool get isQuickOrder => roomId == null && tableId == null;

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);
}
