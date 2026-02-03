// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shift_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ShiftReport _$ShiftReportFromJson(Map<String, dynamic> json) {
  return _ShiftReport.fromJson(json);
}

/// @nodoc
mixin _$ShiftReport {
  @JsonKey(name: 'total_cash')
  double get totalCash => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_card')
  double get totalCard => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_revenue')
  double get totalRevenue => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_discount')
  double get totalDiscount => throw _privateConstructorUsedError;
  @JsonKey(name: 'transactions_count')
  int get transactionsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'generated_at')
  DateTime? get generatedAt => throw _privateConstructorUsedError;

  /// Serializes this ShiftReport to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShiftReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShiftReportCopyWith<ShiftReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShiftReportCopyWith<$Res> {
  factory $ShiftReportCopyWith(
    ShiftReport value,
    $Res Function(ShiftReport) then,
  ) = _$ShiftReportCopyWithImpl<$Res, ShiftReport>;
  @useResult
  $Res call({
    @JsonKey(name: 'total_cash') double totalCash,
    @JsonKey(name: 'total_card') double totalCard,
    @JsonKey(name: 'total_revenue') double totalRevenue,
    @JsonKey(name: 'total_discount') double totalDiscount,
    @JsonKey(name: 'transactions_count') int transactionsCount,
    @JsonKey(name: 'generated_at') DateTime? generatedAt,
  });
}

/// @nodoc
class _$ShiftReportCopyWithImpl<$Res, $Val extends ShiftReport>
    implements $ShiftReportCopyWith<$Res> {
  _$ShiftReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShiftReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCash = null,
    Object? totalCard = null,
    Object? totalRevenue = null,
    Object? totalDiscount = null,
    Object? transactionsCount = null,
    Object? generatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            totalCash: null == totalCash
                ? _value.totalCash
                : totalCash // ignore: cast_nullable_to_non_nullable
                      as double,
            totalCard: null == totalCard
                ? _value.totalCard
                : totalCard // ignore: cast_nullable_to_non_nullable
                      as double,
            totalRevenue: null == totalRevenue
                ? _value.totalRevenue
                : totalRevenue // ignore: cast_nullable_to_non_nullable
                      as double,
            totalDiscount: null == totalDiscount
                ? _value.totalDiscount
                : totalDiscount // ignore: cast_nullable_to_non_nullable
                      as double,
            transactionsCount: null == transactionsCount
                ? _value.transactionsCount
                : transactionsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            generatedAt: freezed == generatedAt
                ? _value.generatedAt
                : generatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ShiftReportImplCopyWith<$Res>
    implements $ShiftReportCopyWith<$Res> {
  factory _$$ShiftReportImplCopyWith(
    _$ShiftReportImpl value,
    $Res Function(_$ShiftReportImpl) then,
  ) = __$$ShiftReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'total_cash') double totalCash,
    @JsonKey(name: 'total_card') double totalCard,
    @JsonKey(name: 'total_revenue') double totalRevenue,
    @JsonKey(name: 'total_discount') double totalDiscount,
    @JsonKey(name: 'transactions_count') int transactionsCount,
    @JsonKey(name: 'generated_at') DateTime? generatedAt,
  });
}

/// @nodoc
class __$$ShiftReportImplCopyWithImpl<$Res>
    extends _$ShiftReportCopyWithImpl<$Res, _$ShiftReportImpl>
    implements _$$ShiftReportImplCopyWith<$Res> {
  __$$ShiftReportImplCopyWithImpl(
    _$ShiftReportImpl _value,
    $Res Function(_$ShiftReportImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShiftReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCash = null,
    Object? totalCard = null,
    Object? totalRevenue = null,
    Object? totalDiscount = null,
    Object? transactionsCount = null,
    Object? generatedAt = freezed,
  }) {
    return _then(
      _$ShiftReportImpl(
        totalCash: null == totalCash
            ? _value.totalCash
            : totalCash // ignore: cast_nullable_to_non_nullable
                  as double,
        totalCard: null == totalCard
            ? _value.totalCard
            : totalCard // ignore: cast_nullable_to_non_nullable
                  as double,
        totalRevenue: null == totalRevenue
            ? _value.totalRevenue
            : totalRevenue // ignore: cast_nullable_to_non_nullable
                  as double,
        totalDiscount: null == totalDiscount
            ? _value.totalDiscount
            : totalDiscount // ignore: cast_nullable_to_non_nullable
                  as double,
        transactionsCount: null == transactionsCount
            ? _value.transactionsCount
            : transactionsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        generatedAt: freezed == generatedAt
            ? _value.generatedAt
            : generatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ShiftReportImpl implements _ShiftReport {
  const _$ShiftReportImpl({
    @JsonKey(name: 'total_cash') required this.totalCash,
    @JsonKey(name: 'total_card') required this.totalCard,
    @JsonKey(name: 'total_revenue') required this.totalRevenue,
    @JsonKey(name: 'total_discount') required this.totalDiscount,
    @JsonKey(name: 'transactions_count') required this.transactionsCount,
    @JsonKey(name: 'generated_at') this.generatedAt,
  });

  factory _$ShiftReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShiftReportImplFromJson(json);

  @override
  @JsonKey(name: 'total_cash')
  final double totalCash;
  @override
  @JsonKey(name: 'total_card')
  final double totalCard;
  @override
  @JsonKey(name: 'total_revenue')
  final double totalRevenue;
  @override
  @JsonKey(name: 'total_discount')
  final double totalDiscount;
  @override
  @JsonKey(name: 'transactions_count')
  final int transactionsCount;
  @override
  @JsonKey(name: 'generated_at')
  final DateTime? generatedAt;

  @override
  String toString() {
    return 'ShiftReport(totalCash: $totalCash, totalCard: $totalCard, totalRevenue: $totalRevenue, totalDiscount: $totalDiscount, transactionsCount: $transactionsCount, generatedAt: $generatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShiftReportImpl &&
            (identical(other.totalCash, totalCash) ||
                other.totalCash == totalCash) &&
            (identical(other.totalCard, totalCard) ||
                other.totalCard == totalCard) &&
            (identical(other.totalRevenue, totalRevenue) ||
                other.totalRevenue == totalRevenue) &&
            (identical(other.totalDiscount, totalDiscount) ||
                other.totalDiscount == totalDiscount) &&
            (identical(other.transactionsCount, transactionsCount) ||
                other.transactionsCount == transactionsCount) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalCash,
    totalCard,
    totalRevenue,
    totalDiscount,
    transactionsCount,
    generatedAt,
  );

  /// Create a copy of ShiftReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShiftReportImplCopyWith<_$ShiftReportImpl> get copyWith =>
      __$$ShiftReportImplCopyWithImpl<_$ShiftReportImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShiftReportImplToJson(this);
  }
}

abstract class _ShiftReport implements ShiftReport {
  const factory _ShiftReport({
    @JsonKey(name: 'total_cash') required final double totalCash,
    @JsonKey(name: 'total_card') required final double totalCard,
    @JsonKey(name: 'total_revenue') required final double totalRevenue,
    @JsonKey(name: 'total_discount') required final double totalDiscount,
    @JsonKey(name: 'transactions_count') required final int transactionsCount,
    @JsonKey(name: 'generated_at') final DateTime? generatedAt,
  }) = _$ShiftReportImpl;

  factory _ShiftReport.fromJson(Map<String, dynamic> json) =
      _$ShiftReportImpl.fromJson;

  @override
  @JsonKey(name: 'total_cash')
  double get totalCash;
  @override
  @JsonKey(name: 'total_card')
  double get totalCard;
  @override
  @JsonKey(name: 'total_revenue')
  double get totalRevenue;
  @override
  @JsonKey(name: 'total_discount')
  double get totalDiscount;
  @override
  @JsonKey(name: 'transactions_count')
  int get transactionsCount;
  @override
  @JsonKey(name: 'generated_at')
  DateTime? get generatedAt;

  /// Create a copy of ShiftReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShiftReportImplCopyWith<_$ShiftReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
