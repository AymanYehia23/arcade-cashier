// ignore_for_file: invalid_annotation_target

import 'package:arcade_cashier/src/features/products/domain/product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order.freezed.dart';
part 'order.g.dart';

@freezed
class Order with _$Order {
  const factory Order({
    @JsonKey(includeToJson: false) required int id,
    @JsonKey(name: 'session_id') required int sessionId,
    @JsonKey(name: 'product_id') required int productId,
    required int quantity,
    @JsonKey(name: 'unit_price') required double unitPrice,
    @JsonKey(name: 'total_price', includeToJson: false)
    required double totalPrice,
    @JsonKey(name: 'created_at', includeToJson: false)
    required DateTime createdAt,
    // Joined field from 'products' table
    @JsonKey(name: 'products', includeToJson: false) Product? product,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}
