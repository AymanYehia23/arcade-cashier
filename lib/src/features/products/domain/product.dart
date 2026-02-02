// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required int id,
    required String name,
    required String category,
    @JsonKey(name: 'selling_price') required double sellingPrice,
    @JsonKey(name: 'stock_quantity') required int stockQuantity,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
