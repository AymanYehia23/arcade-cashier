// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'shift_report.freezed.dart';
part 'shift_report.g.dart';

@freezed
class ShiftReport with _$ShiftReport {
  const factory ShiftReport({
    @JsonKey(name: 'total_cash') required double totalCash,
    @JsonKey(name: 'total_card') required double totalCard,
    @JsonKey(name: 'total_revenue') required double totalRevenue,
    @JsonKey(name: 'total_discount') required double totalDiscount,
    @JsonKey(name: 'transactions_count') required int transactionsCount,
    @JsonKey(name: 'generated_at') DateTime? generatedAt,
  }) = _ShiftReport;

  factory ShiftReport.fromJson(Map<String, dynamic> json) =>
      _$ShiftReportFromJson(json);
}
