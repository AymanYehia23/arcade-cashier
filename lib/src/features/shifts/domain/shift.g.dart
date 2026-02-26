// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShiftImpl _$$ShiftImplFromJson(Map<String, dynamic> json) => _$ShiftImpl(
  id: (json['id'] as num?)?.toInt(),
  cashierId: (json['cashier_id'] as num).toInt(),
  status: json['status'] as String? ?? 'open',
  openedAt: json['opened_at'] == null
      ? null
      : DateTime.parse(json['opened_at'] as String),
  startingCash: (json['starting_cash'] as num?)?.toDouble() ?? 0.0,
  actualEndingCash: (json['actual_ending_cash'] as num?)?.toDouble(),
  cashDropped: (json['cash_dropped'] as num?)?.toDouble(),
  cashLeftInDrawer: (json['cash_left_in_drawer'] as num?)?.toDouble(),
  cashierName: json['cashier_name'] as String?,
);

Map<String, dynamic> _$$ShiftImplToJson(_$ShiftImpl instance) =>
    <String, dynamic>{
      'cashier_id': instance.cashierId,
      'status': instance.status,
      'opened_at': instance.openedAt?.toIso8601String(),
      'starting_cash': instance.startingCash,
      'actual_ending_cash': instance.actualEndingCash,
      'cash_dropped': instance.cashDropped,
      'cash_left_in_drawer': instance.cashLeftInDrawer,
      'cashier_name': instance.cashierName,
    };
