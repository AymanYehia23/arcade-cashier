// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'shift_report_summary.freezed.dart';
part 'shift_report_summary.g.dart';

@freezed
class ShiftReportSummary with _$ShiftReportSummary {
  const factory ShiftReportSummary({
    @JsonKey(name: 'shift_id') required int shiftId,
    @Default('closed') String status,
    @JsonKey(name: 'opened_at') DateTime? openedAt,
    @JsonKey(name: 'closed_at') DateTime? closedAt,
    @JsonKey(name: 'cashier_name') String? cashierName,
    @JsonKey(name: 'starting_cash') @Default(0.0) double startingCash,
    @JsonKey(name: 'cash_revenue') @Default(0.0) double cashRevenue,
    @JsonKey(name: 'digital_revenue') @Default(0.0) double digitalRevenue,
    @JsonKey(name: 'total_revenue') @Default(0.0) double totalRevenue,
    @JsonKey(name: 'expected_ending_cash')
    @Default(0.0)
    double expectedEndingCash,
    @JsonKey(name: 'actual_ending_cash') double? actualEndingCash,
    @JsonKey(name: 'cash_dropped') @Default(0.0) double cashDropped,
    @JsonKey(name: 'cash_left_in_drawer') @Default(0.0) double cashLeftInDrawer,
    @Default(0.0) double variance,
    String? notes,
  }) = _ShiftReportSummary;

  const ShiftReportSummary._();

  bool get isClosed => status == 'closed';

  factory ShiftReportSummary.fromJson(Map<String, dynamic> json) =>
      _$ShiftReportSummaryFromJson(json);
}
