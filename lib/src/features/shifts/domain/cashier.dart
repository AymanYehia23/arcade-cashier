// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'cashier.freezed.dart';
part 'cashier.g.dart';

@freezed
class Cashier with _$Cashier {
  const factory Cashier({
    @JsonKey(includeToJson: false) int? id,
    required String name,
    @JsonKey(name: 'pin_code') required String pinCode,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _Cashier;

  const Cashier._();

  factory Cashier.fromJson(Map<String, dynamic> json) =>
      _$CashierFromJson(json);
}
