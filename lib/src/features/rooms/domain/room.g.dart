// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomImpl _$$RoomImplFromJson(Map<String, dynamic> json) => _$RoomImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  deviceType: json['device_type'] as String,
  hourlyRate: (json['hourly_rate'] as num).toDouble(),
  currentStatus: $enumDecode(_$RoomStatusEnumMap, json['current_status']),
);

Map<String, dynamic> _$$RoomImplToJson(_$RoomImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'device_type': instance.deviceType,
      'hourly_rate': instance.hourlyRate,
      'current_status': _$RoomStatusEnumMap[instance.currentStatus]!,
    };

const _$RoomStatusEnumMap = {
  RoomStatus.available: 'available',
  RoomStatus.occupied: 'occupied',
  RoomStatus.maintenance: 'maintenance',
  RoomStatus.held: 'held',
};
