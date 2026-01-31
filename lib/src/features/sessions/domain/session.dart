import 'package:arcade_cashier/src/features/sessions/domain/session_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'session.freezed.dart';
part 'session.g.dart';

enum SessionStatus { active, completed }

@freezed
class Session with _$Session {
  const factory Session({
    required int id,
    required int roomId,
    required DateTime startTime,
    DateTime? endTime,
    required double appliedHourlyRate,
    required bool isMultiMatch,
    @Default(SessionType.open)
    SessionType sessionType,
    int? plannedDurationMinutes,
    @Default('walk_in') String source,
    @Default(SessionStatus.active) SessionStatus status,
  }) = _Session;

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);
}
