// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionImpl _$$SessionImplFromJson(Map<String, dynamic> json) =>
    _$SessionImpl(
      id: (json['id'] as num).toInt(),
      roomId: (json['roomId'] as num).toInt(),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      appliedHourlyRate: (json['appliedHourlyRate'] as num).toDouble(),
      isMultiMatch: json['isMultiMatch'] as bool,
      sessionType:
          $enumDecodeNullable(_$SessionTypeEnumMap, json['sessionType']) ??
          SessionType.open,
      plannedDurationMinutes: (json['plannedDurationMinutes'] as num?)?.toInt(),
      source: json['source'] as String? ?? 'walk_in',
      status:
          $enumDecodeNullable(_$SessionStatusEnumMap, json['status']) ??
          SessionStatus.active,
    );

Map<String, dynamic> _$$SessionImplToJson(_$SessionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roomId': instance.roomId,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'appliedHourlyRate': instance.appliedHourlyRate,
      'isMultiMatch': instance.isMultiMatch,
      'sessionType': _$SessionTypeEnumMap[instance.sessionType]!,
      'plannedDurationMinutes': instance.plannedDurationMinutes,
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
