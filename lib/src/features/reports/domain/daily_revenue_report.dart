// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_revenue_report.freezed.dart';
part 'daily_revenue_report.g.dart';

@freezed
class DailyRevenueReport with _$DailyRevenueReport {
  const factory DailyRevenueReport({
    @JsonKey(name: 'report_date') required DateTime date,
    @JsonKey(name: 'net_revenue') required double netRevenue,
    @JsonKey(name: 'gross_revenue') required double grossRevenue,
    @JsonKey(name: 'total_discount') required double totalDiscount,
    @JsonKey(name: 'total_invoices') required int invoiceCount,
  }) = _DailyRevenueReport;

  factory DailyRevenueReport.fromJson(Map<String, dynamic> json) =>
      _$DailyRevenueReportFromJson(json);
}
