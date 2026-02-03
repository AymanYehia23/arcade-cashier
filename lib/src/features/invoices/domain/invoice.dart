// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'invoice.freezed.dart';
part 'invoice.g.dart';

@freezed
class Invoice with _$Invoice {
  const factory Invoice({
    @JsonKey(includeToJson: false) int? id,
    @JsonKey(name: 'session_id') required int sessionId,
    @JsonKey(name: 'invoice_number') required String invoiceNumber,
    @JsonKey(name: 'shop_name') required String shopName,
    @JsonKey(name: 'total_amount') required double totalAmount,
    @JsonKey(name: 'payment_method') @Default('cash') String paymentMethod,
    @JsonKey(name: 'discount_amount') @Default(0.0) double discountAmount,
    @JsonKey(name: 'discount_percentage')
    @Default(0.0)
    double discountPercentage,
    @JsonKey(name: 'issued_at') DateTime? issuedAt,
    @Default('paid') String status,
    @JsonKey(name: 'cancelled_at') DateTime? cancelledAt,
    @JsonKey(name: 'customer_id') int? customerId,
    @JsonKey(name: 'customer_name') String? customerName,
  }) = _Invoice;

  const Invoice._();

  bool get isCancelled => status == 'cancelled';

  factory Invoice.fromJson(Map<String, dynamic> json) =>
      _$InvoiceFromJson(json);
}
