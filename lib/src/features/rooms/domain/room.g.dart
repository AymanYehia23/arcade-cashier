// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomImpl _$$RoomImplFromJson(Map<String, dynamic> json) => _$RoomImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  deviceType: $enumDecode(_$DeviceTypeEnumMap, json['device_type']),
  singleMatchHourlyRate: (json['hourly_rate'] as num).toDouble(),
  multiMatchHourlyRate: (json['multi_player_hourly_rate'] as num).toDouble(),
  currentStatus: $enumDecode(_$RoomStatusEnumMap, json['current_status']),
);

Map<String, dynamic> _$$RoomImplToJson(_$RoomImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'device_type': _$DeviceTypeEnumMap[instance.deviceType]!,
      'hourly_rate': instance.singleMatchHourlyRate,
      'multi_player_hourly_rate': instance.multiMatchHourlyRate,
      'current_status': _$RoomStatusEnumMap[instance.currentStatus]!,
    };

const _$DeviceTypeEnumMap = {
  DeviceType.playStation4: 'PlayStation 4',
  DeviceType.playStation5: 'PlayStation 5',
};

const _$RoomStatusEnumMap = {
  RoomStatus.available: 'available',
  RoomStatus.occupied: 'occupied',
  RoomStatus.maintenance: 'maintenance',
  RoomStatus.held: 'held',
};
