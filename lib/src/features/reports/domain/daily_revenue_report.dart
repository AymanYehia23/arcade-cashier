import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_revenue_report.freezed.dart';
part 'daily_revenue_report.g.dart';

@freezed
class DailyRevenueReport with _$DailyRevenueReport {
  const factory DailyRevenueReport({
    @JsonKey(name: 'report_date') required DateTime date,
    @JsonKey(name: 'total_revenue') required double totalRevenue,
    @JsonKey(name: 'total_invoices') required int invoiceCount,
  }) = _DailyRevenueReport;

  factory DailyRevenueReport.fromJson(Map<String, dynamic> json) =>
      _$DailyRevenueReportFromJson(json);
}
