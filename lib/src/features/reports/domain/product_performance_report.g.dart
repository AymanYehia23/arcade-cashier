// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_performance_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductPerformanceReportImpl _$$ProductPerformanceReportImplFromJson(
  Map<String, dynamic> json,
) => _$ProductPerformanceReportImpl(
  productName: json['product_name'] as String,
  productNameAr: json['product_name_ar'] as String?,
  totalSold: (json['total_sold'] as num).toInt(),
  revenue: (json['total_revenue'] as num).toDouble(),
);

Map<String, dynamic> _$$ProductPerformanceReportImplToJson(
  _$ProductPerformanceReportImpl instance,
) => <String, dynamic>{
  'product_name': instance.productName,
  'product_name_ar': instance.productNameAr,
  'total_sold': instance.totalSold,
  'total_revenue': instance.revenue,
};
