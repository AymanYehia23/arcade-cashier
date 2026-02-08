// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cafe_table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CafeTableImpl _$$CafeTableImplFromJson(Map<String, dynamic> json) =>
    _$CafeTableImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      tableNumber: (json['table_number'] as num?)?.toInt(),
      currentStatus: $enumDecode(_$TableStatusEnumMap, json['current_status']),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$CafeTableImplToJson(_$CafeTableImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'table_number': instance.tableNumber,
      'current_status': _$TableStatusEnumMap[instance.currentStatus]!,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

const _$TableStatusEnumMap = {
  TableStatus.available: 'available',
  TableStatus.occupied: 'occupied',
  TableStatus.maintenance: 'maintenance',
};
