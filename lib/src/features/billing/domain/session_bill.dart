import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_bill.freezed.dart';

@freezed
class SessionBill with _$SessionBill {
  const factory SessionBill({
    required double timeCost,
    required double ordersTotal,
    required double totalAmount,
    required Duration duration,
  }) = _SessionBill;
}
