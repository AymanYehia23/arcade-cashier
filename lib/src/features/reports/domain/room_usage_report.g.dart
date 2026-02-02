// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_usage_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomUsageReportImpl _$$RoomUsageReportImplFromJson(
  Map<String, dynamic> json,
) => _$RoomUsageReportImpl(
  roomName: json['room_name'] as String,
  sessions: (json['total_sessions'] as num).toInt(),
  totalHours: (json['total_hours'] as num).toDouble(),
);

Map<String, dynamic> _$$RoomUsageReportImplToJson(
  _$RoomUsageReportImpl instance,
) => <String, dynamic>{
  'room_name': instance.roomName,
  'total_sessions': instance.sessions,
  'total_hours': instance.totalHours,
};
