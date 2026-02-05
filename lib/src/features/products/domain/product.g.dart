// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      nameAr: json['name_ar'] as String,
      category: json['category'] as String,
      categoryAr: json['category_ar'] as String,
      sellingPrice: (json['selling_price'] as num).toDouble(),
      stockQuantity: (json['stock_quantity'] as num).toInt(),
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_ar': instance.nameAr,
      'category': instance.category,
      'category_ar': instance.categoryAr,
      'selling_price': instance.sellingPrice,
      'stock_quantity': instance.stockQuantity,
      'is_active': instance.isActive,
    };
