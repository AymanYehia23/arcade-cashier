// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const Product._();

  const factory Product({
    required int id,
    required String name, // English name (base field)
    @JsonKey(name: 'name_ar') required String nameAr, // Arabic name
    required String category, // English category (base field)
    @JsonKey(name: 'category_ar') required String categoryAr, // Arabic category
    @JsonKey(name: 'selling_price') required double sellingPrice,
    @JsonKey(name: 'stock_quantity') required int stockQuantity,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  /// Get localized name based on language code
  String getLocalizedName(String languageCode) {
    return languageCode == 'ar'
        ? (nameAr.isNotEmpty ? nameAr : name)
        : name;
  }

  /// Get localized category based on language code
  String getLocalizedCategory(String languageCode) {
    return languageCode == 'ar'
        ? (categoryAr.isNotEmpty ? categoryAr : category)
        : category;
  }
}
