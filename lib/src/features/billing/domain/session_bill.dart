import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_bill.freezed.dart';

@freezed
class SessionBill with _$SessionBill {
  const factory SessionBill({
    required double timeCost,
    required double ordersTotal,
    required double totalAmount,
    @Default(0.0) double discountAmount,
    @Default(0.0) double discountPercentage,
    required Duration duration,
  }) = _SessionBill;

  const SessionBill._();

  double get subtotal => timeCost + ordersTotal;
}
