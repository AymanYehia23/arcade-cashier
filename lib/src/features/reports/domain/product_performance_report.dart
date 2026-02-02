import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_performance_report.freezed.dart';
part 'product_performance_report.g.dart';

@freezed
class ProductPerformanceReport with _$ProductPerformanceReport {
  const factory ProductPerformanceReport({
    @JsonKey(name: 'product_name') required String productName,
    @JsonKey(name: 'total_sold') required int totalSold,
    @JsonKey(name: 'total_revenue') required double revenue,
  }) = _ProductPerformanceReport;

  factory ProductPerformanceReport.fromJson(Map<String, dynamic> json) =>
      _$ProductPerformanceReportFromJson(json);
}
