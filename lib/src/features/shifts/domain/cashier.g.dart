// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cashier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CashierImpl _$$CashierImplFromJson(Map<String, dynamic> json) =>
    _$CashierImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      pinCode: json['pin_code'] as String,
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$$CashierImplToJson(_$CashierImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'pin_code': instance.pinCode,
      'is_active': instance.isActive,
    };
