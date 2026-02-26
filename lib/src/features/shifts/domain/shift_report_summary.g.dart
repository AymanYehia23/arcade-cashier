// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_report_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShiftReportSummaryImpl _$$ShiftReportSummaryImplFromJson(
  Map<String, dynamic> json,
) => _$ShiftReportSummaryImpl(
  shiftId: (json['shift_id'] as num).toInt(),
  status: json['status'] as String? ?? 'closed',
  openedAt: json['opened_at'] == null
      ? null
      : DateTime.parse(json['opened_at'] as String),
  closedAt: json['closed_at'] == null
      ? null
      : DateTime.parse(json['closed_at'] as String),
  cashierName: json['cashier_name'] as String?,
  startingCash: (json['starting_cash'] as num?)?.toDouble() ?? 0.0,
  cashRevenue: (json['cash_revenue'] as num?)?.toDouble() ?? 0.0,
  digitalRevenue: (json['digital_revenue'] as num?)?.toDouble() ?? 0.0,
  totalRevenue: (json['total_revenue'] as num?)?.toDouble() ?? 0.0,
  expectedEndingCash: (json['expected_ending_cash'] as num?)?.toDouble() ?? 0.0,
  actualEndingCash: (json['actual_ending_cash'] as num?)?.toDouble(),
  cashDropped: (json['cash_dropped'] as num?)?.toDouble() ?? 0.0,
  cashLeftInDrawer: (json['cash_left_in_drawer'] as num?)?.toDouble() ?? 0.0,
  variance: (json['variance'] as num?)?.toDouble() ?? 0.0,
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$$ShiftReportSummaryImplToJson(
  _$ShiftReportSummaryImpl instance,
) => <String, dynamic>{
  'shift_id': instance.shiftId,
  'status': instance.status,
  'opened_at': instance.openedAt?.toIso8601String(),
  'closed_at': instance.closedAt?.toIso8601String(),
  'cashier_name': instance.cashierName,
  'starting_cash': instance.startingCash,
  'cash_revenue': instance.cashRevenue,
  'digital_revenue': instance.digitalRevenue,
  'total_revenue': instance.totalRevenue,
  'expected_ending_cash': instance.expectedEndingCash,
  'actual_ending_cash': instance.actualEndingCash,
  'cash_dropped': instance.cashDropped,
  'cash_left_in_drawer': instance.cashLeftInDrawer,
  'variance': instance.variance,
  'notes': instance.notes,
};
