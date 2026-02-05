// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_usage_report.freezed.dart';
part 'room_usage_report.g.dart';

@freezed
class RoomUsageReport with _$RoomUsageReport {
  const factory RoomUsageReport({
    @JsonKey(name: 'room_name') required String roomName,
    @JsonKey(name: 'total_sessions') required int sessions,
    @JsonKey(name: 'total_hours') required double totalHours,
  }) = _RoomUsageReport;

  factory RoomUsageReport.fromJson(Map<String, dynamic> json) =>
      _$RoomUsageReportFromJson(json);
}
