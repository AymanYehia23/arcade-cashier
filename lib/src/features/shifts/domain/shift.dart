// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'shift.freezed.dart';
part 'shift.g.dart';

@freezed
class Shift with _$Shift {
  const factory Shift({
    @JsonKey(includeToJson: false) int? id,
    @JsonKey(name: 'cashier_id') required int cashierId,
    @Default('open') String status,
    @JsonKey(name: 'opened_at') DateTime? openedAt,
    @JsonKey(name: 'starting_cash') @Default(0.0) double startingCash,
    @JsonKey(name: 'actual_ending_cash') double? actualEndingCash,
    @JsonKey(name: 'cash_dropped') double? cashDropped,
    @JsonKey(name: 'cash_left_in_drawer') double? cashLeftInDrawer,
    // Joined field — populated when fetching with cashier join
    @JsonKey(name: 'cashier_name') String? cashierName,
  }) = _Shift;

  const Shift._();

  bool get isOpen => status == 'open';

  factory Shift.fromJson(Map<String, dynamic> json) => _$ShiftFromJson(json);
}
