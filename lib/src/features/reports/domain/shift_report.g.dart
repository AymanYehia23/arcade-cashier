// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShiftReportImpl _$$ShiftReportImplFromJson(Map<String, dynamic> json) =>
    _$ShiftReportImpl(
      totalCash: (json['total_cash'] as num).toDouble(),
      totalCard: (json['total_card'] as num).toDouble(),
      totalRevenue: (json['total_revenue'] as num).toDouble(),
      totalDiscount: (json['total_discount'] as num).toDouble(),
      transactionsCount: (json['transactions_count'] as num).toInt(),
      generatedAt: json['generated_at'] == null
          ? null
          : DateTime.parse(json['generated_at'] as String),
    );

Map<String, dynamic> _$$ShiftReportImplToJson(_$ShiftReportImpl instance) =>
    <String, dynamic>{
      'total_cash': instance.totalCash,
      'total_card': instance.totalCard,
      'total_revenue': instance.totalRevenue,
      'total_discount': instance.totalDiscount,
      'transactions_count': instance.transactionsCount,
      'generated_at': instance.generatedAt?.toIso8601String(),
    };
