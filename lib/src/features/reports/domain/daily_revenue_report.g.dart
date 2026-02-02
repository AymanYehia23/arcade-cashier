// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_revenue_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyRevenueReportImpl _$$DailyRevenueReportImplFromJson(
  Map<String, dynamic> json,
) => _$DailyRevenueReportImpl(
  date: DateTime.parse(json['report_date'] as String),
  totalRevenue: (json['total_revenue'] as num).toDouble(),
  invoiceCount: (json['total_invoices'] as num).toInt(),
);

Map<String, dynamic> _$$DailyRevenueReportImplToJson(
  _$DailyRevenueReportImpl instance,
) => <String, dynamic>{
  'report_date': instance.date.toIso8601String(),
  'total_revenue': instance.totalRevenue,
  'total_invoices': instance.invoiceCount,
};
