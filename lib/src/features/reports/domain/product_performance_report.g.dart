// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_performance_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductPerformanceReportImpl _$$ProductPerformanceReportImplFromJson(
  Map<String, dynamic> json,
) => _$ProductPerformanceReportImpl(
  productName: json['product_name'] as String,
  totalSold: (json['total_sold'] as num).toInt(),
  revenue: (json['total_revenue'] as num).toDouble(),
);

Map<String, dynamic> _$$ProductPerformanceReportImplToJson(
  _$ProductPerformanceReportImpl instance,
) => <String, dynamic>{
  'product_name': instance.productName,
  'total_sold': instance.totalSold,
  'total_revenue': instance.revenue,
};
