// ignore_for_file: invalid_annotation_target

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_performance_report.freezed.dart';
part 'product_performance_report.g.dart';

@freezed
class ProductPerformanceReport with _$ProductPerformanceReport {
  const ProductPerformanceReport._();

  const factory ProductPerformanceReport({
    @JsonKey(name: 'product_name') required String productName,
    @JsonKey(name: 'product_name_ar') String? productNameAr,
    @JsonKey(name: 'total_sold') required int totalSold,
    @JsonKey(name: 'total_revenue') required double revenue,
  }) = _ProductPerformanceReport;

  factory ProductPerformanceReport.fromJson(Map<String, dynamic> json) =>
      _$ProductPerformanceReportFromJson(json);

  String getLocalizedName(Locale locale) {
    // If Arabic is selected but no Arabic name available, fall back to English
    return locale.languageCode == 'ar' && productNameAr != null
        ? productNameAr!
        : productName;
  }
}
