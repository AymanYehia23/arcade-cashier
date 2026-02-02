// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionImpl _$$SessionImplFromJson(Map<String, dynamic> json) =>
    _$SessionImpl(
      id: (json['id'] as num).toInt(),
      roomId: (json['room_id'] as num?)?.toInt(),
      startTime: DateTime.parse(json['start_time'] as String),
      endTime: json['end_time'] == null
          ? null
          : DateTime.parse(json['end_time'] as String),
      appliedHourlyRate: (json['applied_hourly_rate'] as num).toDouble(),
      isMultiMatch: json['is_multi_match'] as bool,
      sessionType:
          $enumDecodeNullable(_$SessionTypeEnumMap, json['session_type']) ??
          SessionType.open,
      plannedDurationMinutes: (json['planned_duration_minutes'] as num?)
          ?.toInt(),
      source: json['source'] as String? ?? 'walk_in',
      status:
          $enumDecodeNullable(_$SessionStatusEnumMap, json['status']) ??
          SessionStatus.active,
    );

Map<String, dynamic> _$$SessionImplToJson(_$SessionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'room_id': instance.roomId,
      'start_time': instance.startTime.toIso8601String(),
      'end_time': instance.endTime?.toIso8601String(),
      'applied_hourly_rate': instance.appliedHourlyRate,
      'is_multi_match': instance.isMultiMatch,
      'session_type': _$SessionTypeEnumMap[instance.sessionType]!,
      'planned_duration_minutes': instance.plannedDurationMinutes,
      'source': instance.source,
      'status': _$SessionStatusEnumMap[instance.status]!,
    };

const _$SessionTypeEnumMap = {
  SessionType.open: 'open',
  SessionType.fixed: 'fixed',
};

const _$SessionStatusEnumMap = {
  SessionStatus.active: 'active',
  SessionStatus.completed: 'completed',
};
