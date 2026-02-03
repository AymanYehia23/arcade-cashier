// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_revenue_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyRevenueReportImpl _$$DailyRevenueReportImplFromJson(
  Map<String, dynamic> json,
) => _$DailyRevenueReportImpl(
  date: DateTime.parse(json['report_date'] as String),
  netRevenue: (json['net_revenue'] as num).toDouble(),
  grossRevenue: (json['gross_revenue'] as num).toDouble(),
  totalDiscount: (json['total_discount'] as num).toDouble(),
  invoiceCount: (json['total_invoices'] as num).toInt(),
);

Map<String, dynamic> _$$DailyRevenueReportImplToJson(
  _$DailyRevenueReportImpl instance,
) => <String, dynamic>{
  'report_date': instance.date.toIso8601String(),
  'net_revenue': instance.netRevenue,
  'gross_revenue': instance.grossRevenue,
  'total_discount': instance.totalDiscount,
  'total_invoices': instance.invoiceCount,
};
