// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_performance_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProductPerformanceReport _$ProductPerformanceReportFromJson(
  Map<String, dynamic> json,
) {
  return _ProductPerformanceReport.fromJson(json);
}

/// @nodoc
mixin _$ProductPerformanceReport {
  @JsonKey(name: 'product_name')
  String get productName => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_sold')
  int get totalSold => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_revenue')
  double get revenue => throw _privateConstructorUsedError;

  /// Serializes this ProductPerformanceReport to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductPerformanceReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductPerformanceReportCopyWith<ProductPerformanceReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductPerformanceReportCopyWith<$Res> {
  factory $ProductPerformanceReportCopyWith(
    ProductPerformanceReport value,
    $Res Function(ProductPerformanceReport) then,
  ) = _$ProductPerformanceReportCopyWithImpl<$Res, ProductPerformanceReport>;
  @useResult
  $Res call({
    @JsonKey(name: 'product_name') String productName,
    @JsonKey(name: 'total_sold') int totalSold,
    @JsonKey(name: 'total_revenue') double revenue,
  });
}

/// @nodoc
class _$ProductPerformanceReportCopyWithImpl<
  $Res,
  $Val extends ProductPerformanceReport
>
    implements $ProductPerformanceReportCopyWith<$Res> {
  _$ProductPerformanceReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductPerformanceReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productName = null,
    Object? totalSold = null,
    Object? revenue = null,
  }) {
    return _then(
      _value.copyWith(
            productName: null == productName
                ? _value.productName
                : productName // ignore: cast_nullable_to_non_nullable
                      as String,
            totalSold: null == totalSold
                ? _value.totalSold
                : totalSold // ignore: cast_nullable_to_non_nullable
                      as int,
            revenue: null == revenue
                ? _value.revenue
                : revenue // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProductPerformanceReportImplCopyWith<$Res>
    implements $ProductPerformanceReportCopyWith<$Res> {
  factory _$$ProductPerformanceReportImplCopyWith(
    _$ProductPerformanceReportImpl value,
    $Res Function(_$ProductPerformanceReportImpl) then,
  ) = __$$ProductPerformanceReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'product_name') String productName,
    @JsonKey(name: 'total_sold') int totalSold,
    @JsonKey(name: 'total_revenue') double revenue,
  });
}

/// @nodoc
class __$$ProductPerformanceReportImplCopyWithImpl<$Res>
    extends
        _$ProductPerformanceReportCopyWithImpl<
          $Res,
          _$ProductPerformanceReportImpl
        >
    implements _$$ProductPerformanceReportImplCopyWith<$Res> {
  __$$ProductPerformanceReportImplCopyWithImpl(
    _$ProductPerformanceReportImpl _value,
    $Res Function(_$ProductPerformanceReportImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductPerformanceReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productName = null,
    Object? totalSold = null,
    Object? revenue = null,
  }) {
    return _then(
      _$ProductPerformanceReportImpl(
        productName: null == productName
            ? _value.productName
            : productName // ignore: cast_nullable_to_non_nullable
                  as String,
        totalSold: null == totalSold
            ? _value.totalSold
            : totalSold // ignore: cast_nullable_to_non_nullable
                  as int,
        revenue: null == revenue
            ? _value.revenue
            : revenue // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductPerformanceReportImpl implements _ProductPerformanceReport {
  const _$ProductPerformanceReportImpl({
    @JsonKey(name: 'product_name') required this.productName,
    @JsonKey(name: 'total_sold') required this.totalSold,
    @JsonKey(name: 'total_revenue') required this.revenue,
  });

  factory _$ProductPerformanceReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductPerformanceReportImplFromJson(json);

  @override
  @JsonKey(name: 'product_name')
  final String productName;
  @override
  @JsonKey(name: 'total_sold')
  final int totalSold;
  @override
  @JsonKey(name: 'total_revenue')
  final double revenue;

  @override
  String toString() {
    return 'ProductPerformanceReport(productName: $productName, totalSold: $totalSold, revenue: $revenue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductPerformanceReportImpl &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.totalSold, totalSold) ||
                other.totalSold == totalSold) &&
            (identical(other.revenue, revenue) || other.revenue == revenue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, productName, totalSold, revenue);

  /// Create a copy of ProductPerformanceReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductPerformanceReportImplCopyWith<_$ProductPerformanceReportImpl>
  get copyWith =>
      __$$ProductPerformanceReportImplCopyWithImpl<
        _$ProductPerformanceReportImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductPerformanceReportImplToJson(this);
  }
}

abstract class _ProductPerformanceReport implements ProductPerformanceReport {
  const factory _ProductPerformanceReport({
    @JsonKey(name: 'product_name') required final String productName,
    @JsonKey(name: 'total_sold') required final int totalSold,
    @JsonKey(name: 'total_revenue') required final double revenue,
  }) = _$ProductPerformanceReportImpl;

  factory _ProductPerformanceReport.fromJson(Map<String, dynamic> json) =
      _$ProductPerformanceReportImpl.fromJson;

  @override
  @JsonKey(name: 'product_name')
  String get productName;
  @override
  @JsonKey(name: 'total_sold')
  int get totalSold;
  @override
  @JsonKey(name: 'total_revenue')
  double get revenue;

  /// Create a copy of ProductPerformanceReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductPerformanceReportImplCopyWith<_$ProductPerformanceReportImpl>
  get copyWith => throw _privateConstructorUsedError;
}
