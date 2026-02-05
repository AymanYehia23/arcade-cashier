// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
mixin _$Product {
  int get id => throw _privateConstructorUsedError;
  String get name =>
      throw _privateConstructorUsedError; // English name (base field)
  @JsonKey(name: 'name_ar')
  String get nameAr => throw _privateConstructorUsedError; // Arabic name
  String get category =>
      throw _privateConstructorUsedError; // English category (base field)
  @JsonKey(name: 'category_ar')
  String get categoryAr => throw _privateConstructorUsedError; // Arabic category
  @JsonKey(name: 'selling_price')
  double get sellingPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'stock_quantity')
  int get stockQuantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this Product to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call({
    int id,
    String name,
    @JsonKey(name: 'name_ar') String nameAr,
    String category,
    @JsonKey(name: 'category_ar') String categoryAr,
    @JsonKey(name: 'selling_price') double sellingPrice,
    @JsonKey(name: 'stock_quantity') int stockQuantity,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameAr = null,
    Object? category = null,
    Object? categoryAr = null,
    Object? sellingPrice = null,
    Object? stockQuantity = null,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            nameAr: null == nameAr
                ? _value.nameAr
                : nameAr // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryAr: null == categoryAr
                ? _value.categoryAr
                : categoryAr // ignore: cast_nullable_to_non_nullable
                      as String,
            sellingPrice: null == sellingPrice
                ? _value.sellingPrice
                : sellingPrice // ignore: cast_nullable_to_non_nullable
                      as double,
            stockQuantity: null == stockQuantity
                ? _value.stockQuantity
                : stockQuantity // ignore: cast_nullable_to_non_nullable
                      as int,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProductImplCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$ProductImplCopyWith(
    _$ProductImpl value,
    $Res Function(_$ProductImpl) then,
  ) = __$$ProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    @JsonKey(name: 'name_ar') String nameAr,
    String category,
    @JsonKey(name: 'category_ar') String categoryAr,
    @JsonKey(name: 'selling_price') double sellingPrice,
    @JsonKey(name: 'stock_quantity') int stockQuantity,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class __$$ProductImplCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$ProductImpl>
    implements _$$ProductImplCopyWith<$Res> {
  __$$ProductImplCopyWithImpl(
    _$ProductImpl _value,
    $Res Function(_$ProductImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameAr = null,
    Object? category = null,
    Object? categoryAr = null,
    Object? sellingPrice = null,
    Object? stockQuantity = null,
    Object? isActive = null,
  }) {
    return _then(
      _$ProductImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        nameAr: null == nameAr
            ? _value.nameAr
            : nameAr // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryAr: null == categoryAr
            ? _value.categoryAr
            : categoryAr // ignore: cast_nullable_to_non_nullable
                  as String,
        sellingPrice: null == sellingPrice
            ? _value.sellingPrice
            : sellingPrice // ignore: cast_nullable_to_non_nullable
                  as double,
        stockQuantity: null == stockQuantity
            ? _value.stockQuantity
            : stockQuantity // ignore: cast_nullable_to_non_nullable
                  as int,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductImpl extends _Product {
  const _$ProductImpl({
    required this.id,
    required this.name,
    @JsonKey(name: 'name_ar') required this.nameAr,
    required this.category,
    @JsonKey(name: 'category_ar') required this.categoryAr,
    @JsonKey(name: 'selling_price') required this.sellingPrice,
    @JsonKey(name: 'stock_quantity') required this.stockQuantity,
    @JsonKey(name: 'is_active') this.isActive = true,
  }) : super._();

  factory _$ProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  // English name (base field)
  @override
  @JsonKey(name: 'name_ar')
  final String nameAr;
  // Arabic name
  @override
  final String category;
  // English category (base field)
  @override
  @JsonKey(name: 'category_ar')
  final String categoryAr;
  // Arabic category
  @override
  @JsonKey(name: 'selling_price')
  final double sellingPrice;
  @override
  @JsonKey(name: 'stock_quantity')
  final int stockQuantity;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;

  @override
  String toString() {
    return 'Product(id: $id, name: $name, nameAr: $nameAr, category: $category, categoryAr: $categoryAr, sellingPrice: $sellingPrice, stockQuantity: $stockQuantity, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameAr, nameAr) || other.nameAr == nameAr) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.categoryAr, categoryAr) ||
                other.categoryAr == categoryAr) &&
            (identical(other.sellingPrice, sellingPrice) ||
                other.sellingPrice == sellingPrice) &&
            (identical(other.stockQuantity, stockQuantity) ||
                other.stockQuantity == stockQuantity) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    nameAr,
    category,
    categoryAr,
    sellingPrice,
    stockQuantity,
    isActive,
  );

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      __$$ProductImplCopyWithImpl<_$ProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductImplToJson(this);
  }
}

abstract class _Product extends Product {
  const factory _Product({
    required final int id,
    required final String name,
    @JsonKey(name: 'name_ar') required final String nameAr,
    required final String category,
    @JsonKey(name: 'category_ar') required final String categoryAr,
    @JsonKey(name: 'selling_price') required final double sellingPrice,
    @JsonKey(name: 'stock_quantity') required final int stockQuantity,
    @JsonKey(name: 'is_active') final bool isActive,
  }) = _$ProductImpl;
  const _Product._() : super._();

  factory _Product.fromJson(Map<String, dynamic> json) = _$ProductImpl.fromJson;

  @override
  int get id;
  @override
  String get name; // English name (base field)
  @override
  @JsonKey(name: 'name_ar')
  String get nameAr; // Arabic name
  @override
  String get category; // English category (base field)
  @override
  @JsonKey(name: 'category_ar')
  String get categoryAr; // Arabic category
  @override
  @JsonKey(name: 'selling_price')
  double get sellingPrice;
  @override
  @JsonKey(name: 'stock_quantity')
  int get stockQuantity;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
