// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shift_report_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ShiftReportSummary _$ShiftReportSummaryFromJson(Map<String, dynamic> json) {
  return _ShiftReportSummary.fromJson(json);
}

/// @nodoc
mixin _$ShiftReportSummary {
  @JsonKey(name: 'shift_id')
  int get shiftId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'opened_at')
  DateTime? get openedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'closed_at')
  DateTime? get closedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'cashier_name')
  String? get cashierName => throw _privateConstructorUsedError;
  @JsonKey(name: 'starting_cash')
  double get startingCash => throw _privateConstructorUsedError;
  @JsonKey(name: 'cash_revenue')
  double get cashRevenue => throw _privateConstructorUsedError;
  @JsonKey(name: 'digital_revenue')
  double get digitalRevenue => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_revenue')
  double get totalRevenue => throw _privateConstructorUsedError;
  @JsonKey(name: 'expected_ending_cash')
  double get expectedEndingCash => throw _privateConstructorUsedError;
  @JsonKey(name: 'actual_ending_cash')
  double? get actualEndingCash => throw _privateConstructorUsedError;
  @JsonKey(name: 'cash_dropped')
  double get cashDropped => throw _privateConstructorUsedError;
  @JsonKey(name: 'cash_left_in_drawer')
  double get cashLeftInDrawer => throw _privateConstructorUsedError;
  double get variance => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this ShiftReportSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShiftReportSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShiftReportSummaryCopyWith<ShiftReportSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShiftReportSummaryCopyWith<$Res> {
  factory $ShiftReportSummaryCopyWith(
    ShiftReportSummary value,
    $Res Function(ShiftReportSummary) then,
  ) = _$ShiftReportSummaryCopyWithImpl<$Res, ShiftReportSummary>;
  @useResult
  $Res call({
    @JsonKey(name: 'shift_id') int shiftId,
    String status,
    @JsonKey(name: 'opened_at') DateTime? openedAt,
    @JsonKey(name: 'closed_at') DateTime? closedAt,
    @JsonKey(name: 'cashier_name') String? cashierName,
    @JsonKey(name: 'starting_cash') double startingCash,
    @JsonKey(name: 'cash_revenue') double cashRevenue,
    @JsonKey(name: 'digital_revenue') double digitalRevenue,
    @JsonKey(name: 'total_revenue') double totalRevenue,
    @JsonKey(name: 'expected_ending_cash') double expectedEndingCash,
    @JsonKey(name: 'actual_ending_cash') double? actualEndingCash,
    @JsonKey(name: 'cash_dropped') double cashDropped,
    @JsonKey(name: 'cash_left_in_drawer') double cashLeftInDrawer,
    double variance,
    String? notes,
  });
}

/// @nodoc
class _$ShiftReportSummaryCopyWithImpl<$Res, $Val extends ShiftReportSummary>
    implements $ShiftReportSummaryCopyWith<$Res> {
  _$ShiftReportSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShiftReportSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shiftId = null,
    Object? status = null,
    Object? openedAt = freezed,
    Object? closedAt = freezed,
    Object? cashierName = freezed,
    Object? startingCash = null,
    Object? cashRevenue = null,
    Object? digitalRevenue = null,
    Object? totalRevenue = null,
    Object? expectedEndingCash = null,
    Object? actualEndingCash = freezed,
    Object? cashDropped = null,
    Object? cashLeftInDrawer = null,
    Object? variance = null,
    Object? notes = freezed,
  }) {
    return _then(
      _value.copyWith(
            shiftId: null == shiftId
                ? _value.shiftId
                : shiftId // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            openedAt: freezed == openedAt
                ? _value.openedAt
                : openedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            closedAt: freezed == closedAt
                ? _value.closedAt
                : closedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            cashierName: freezed == cashierName
                ? _value.cashierName
                : cashierName // ignore: cast_nullable_to_non_nullable
                      as String?,
            startingCash: null == startingCash
                ? _value.startingCash
                : startingCash // ignore: cast_nullable_to_non_nullable
                      as double,
            cashRevenue: null == cashRevenue
                ? _value.cashRevenue
                : cashRevenue // ignore: cast_nullable_to_non_nullable
                      as double,
            digitalRevenue: null == digitalRevenue
                ? _value.digitalRevenue
                : digitalRevenue // ignore: cast_nullable_to_non_nullable
                      as double,
            totalRevenue: null == totalRevenue
                ? _value.totalRevenue
                : totalRevenue // ignore: cast_nullable_to_non_nullable
                      as double,
            expectedEndingCash: null == expectedEndingCash
                ? _value.expectedEndingCash
                : expectedEndingCash // ignore: cast_nullable_to_non_nullable
                      as double,
            actualEndingCash: freezed == actualEndingCash
                ? _value.actualEndingCash
                : actualEndingCash // ignore: cast_nullable_to_non_nullable
                      as double?,
            cashDropped: null == cashDropped
                ? _value.cashDropped
                : cashDropped // ignore: cast_nullable_to_non_nullable
                      as double,
            cashLeftInDrawer: null == cashLeftInDrawer
                ? _value.cashLeftInDrawer
                : cashLeftInDrawer // ignore: cast_nullable_to_non_nullable
                      as double,
            variance: null == variance
                ? _value.variance
                : variance // ignore: cast_nullable_to_non_nullable
                      as double,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ShiftReportSummaryImplCopyWith<$Res>
    implements $ShiftReportSummaryCopyWith<$Res> {
  factory _$$ShiftReportSummaryImplCopyWith(
    _$ShiftReportSummaryImpl value,
    $Res Function(_$ShiftReportSummaryImpl) then,
  ) = __$$ShiftReportSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'shift_id') int shiftId,
    String status,
    @JsonKey(name: 'opened_at') DateTime? openedAt,
    @JsonKey(name: 'closed_at') DateTime? closedAt,
    @JsonKey(name: 'cashier_name') String? cashierName,
    @JsonKey(name: 'starting_cash') double startingCash,
    @JsonKey(name: 'cash_revenue') double cashRevenue,
    @JsonKey(name: 'digital_revenue') double digitalRevenue,
    @JsonKey(name: 'total_revenue') double totalRevenue,
    @JsonKey(name: 'expected_ending_cash') double expectedEndingCash,
    @JsonKey(name: 'actual_ending_cash') double? actualEndingCash,
    @JsonKey(name: 'cash_dropped') double cashDropped,
    @JsonKey(name: 'cash_left_in_drawer') double cashLeftInDrawer,
    double variance,
    String? notes,
  });
}

/// @nodoc
class __$$ShiftReportSummaryImplCopyWithImpl<$Res>
    extends _$ShiftReportSummaryCopyWithImpl<$Res, _$ShiftReportSummaryImpl>
    implements _$$ShiftReportSummaryImplCopyWith<$Res> {
  __$$ShiftReportSummaryImplCopyWithImpl(
    _$ShiftReportSummaryImpl _value,
    $Res Function(_$ShiftReportSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShiftReportSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shiftId = null,
    Object? status = null,
    Object? openedAt = freezed,
    Object? closedAt = freezed,
    Object? cashierName = freezed,
    Object? startingCash = null,
    Object? cashRevenue = null,
    Object? digitalRevenue = null,
    Object? totalRevenue = null,
    Object? expectedEndingCash = null,
    Object? actualEndingCash = freezed,
    Object? cashDropped = null,
    Object? cashLeftInDrawer = null,
    Object? variance = null,
    Object? notes = freezed,
  }) {
    return _then(
      _$ShiftReportSummaryImpl(
        shiftId: null == shiftId
            ? _value.shiftId
            : shiftId // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        openedAt: freezed == openedAt
            ? _value.openedAt
            : openedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        closedAt: freezed == closedAt
            ? _value.closedAt
            : closedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        cashierName: freezed == cashierName
            ? _value.cashierName
            : cashierName // ignore: cast_nullable_to_non_nullable
                  as String?,
        startingCash: null == startingCash
            ? _value.startingCash
            : startingCash // ignore: cast_nullable_to_non_nullable
                  as double,
        cashRevenue: null == cashRevenue
            ? _value.cashRevenue
            : cashRevenue // ignore: cast_nullable_to_non_nullable
                  as double,
        digitalRevenue: null == digitalRevenue
            ? _value.digitalRevenue
            : digitalRevenue // ignore: cast_nullable_to_non_nullable
                  as double,
        totalRevenue: null == totalRevenue
            ? _value.totalRevenue
            : totalRevenue // ignore: cast_nullable_to_non_nullable
                  as double,
        expectedEndingCash: null == expectedEndingCash
            ? _value.expectedEndingCash
            : expectedEndingCash // ignore: cast_nullable_to_non_nullable
                  as double,
        actualEndingCash: freezed == actualEndingCash
            ? _value.actualEndingCash
            : actualEndingCash // ignore: cast_nullable_to_non_nullable
                  as double?,
        cashDropped: null == cashDropped
            ? _value.cashDropped
            : cashDropped // ignore: cast_nullable_to_non_nullable
                  as double,
        cashLeftInDrawer: null == cashLeftInDrawer
            ? _value.cashLeftInDrawer
            : cashLeftInDrawer // ignore: cast_nullable_to_non_nullable
                  as double,
        variance: null == variance
            ? _value.variance
            : variance // ignore: cast_nullable_to_non_nullable
                  as double,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ShiftReportSummaryImpl extends _ShiftReportSummary {
  const _$ShiftReportSummaryImpl({
    @JsonKey(name: 'shift_id') required this.shiftId,
    this.status = 'closed',
    @JsonKey(name: 'opened_at') this.openedAt,
    @JsonKey(name: 'closed_at') this.closedAt,
    @JsonKey(name: 'cashier_name') this.cashierName,
    @JsonKey(name: 'starting_cash') this.startingCash = 0.0,
    @JsonKey(name: 'cash_revenue') this.cashRevenue = 0.0,
    @JsonKey(name: 'digital_revenue') this.digitalRevenue = 0.0,
    @JsonKey(name: 'total_revenue') this.totalRevenue = 0.0,
    @JsonKey(name: 'expected_ending_cash') this.expectedEndingCash = 0.0,
    @JsonKey(name: 'actual_ending_cash') this.actualEndingCash,
    @JsonKey(name: 'cash_dropped') this.cashDropped = 0.0,
    @JsonKey(name: 'cash_left_in_drawer') this.cashLeftInDrawer = 0.0,
    this.variance = 0.0,
    this.notes,
  }) : super._();

  factory _$ShiftReportSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShiftReportSummaryImplFromJson(json);

  @override
  @JsonKey(name: 'shift_id')
  final int shiftId;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey(name: 'opened_at')
  final DateTime? openedAt;
  @override
  @JsonKey(name: 'closed_at')
  final DateTime? closedAt;
  @override
  @JsonKey(name: 'cashier_name')
  final String? cashierName;
  @override
  @JsonKey(name: 'starting_cash')
  final double startingCash;
  @override
  @JsonKey(name: 'cash_revenue')
  final double cashRevenue;
  @override
  @JsonKey(name: 'digital_revenue')
  final double digitalRevenue;
  @override
  @JsonKey(name: 'total_revenue')
  final double totalRevenue;
  @override
  @JsonKey(name: 'expected_ending_cash')
  final double expectedEndingCash;
  @override
  @JsonKey(name: 'actual_ending_cash')
  final double? actualEndingCash;
  @override
  @JsonKey(name: 'cash_dropped')
  final double cashDropped;
  @override
  @JsonKey(name: 'cash_left_in_drawer')
  final double cashLeftInDrawer;
  @override
  @JsonKey()
  final double variance;
  @override
  final String? notes;

  @override
  String toString() {
    return 'ShiftReportSummary(shiftId: $shiftId, status: $status, openedAt: $openedAt, closedAt: $closedAt, cashierName: $cashierName, startingCash: $startingCash, cashRevenue: $cashRevenue, digitalRevenue: $digitalRevenue, totalRevenue: $totalRevenue, expectedEndingCash: $expectedEndingCash, actualEndingCash: $actualEndingCash, cashDropped: $cashDropped, cashLeftInDrawer: $cashLeftInDrawer, variance: $variance, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShiftReportSummaryImpl &&
            (identical(other.shiftId, shiftId) || other.shiftId == shiftId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.openedAt, openedAt) ||
                other.openedAt == openedAt) &&
            (identical(other.closedAt, closedAt) ||
                other.closedAt == closedAt) &&
            (identical(other.cashierName, cashierName) ||
                other.cashierName == cashierName) &&
            (identical(other.startingCash, startingCash) ||
                other.startingCash == startingCash) &&
            (identical(other.cashRevenue, cashRevenue) ||
                other.cashRevenue == cashRevenue) &&
            (identical(other.digitalRevenue, digitalRevenue) ||
                other.digitalRevenue == digitalRevenue) &&
            (identical(other.totalRevenue, totalRevenue) ||
                other.totalRevenue == totalRevenue) &&
            (identical(other.expectedEndingCash, expectedEndingCash) ||
                other.expectedEndingCash == expectedEndingCash) &&
            (identical(other.actualEndingCash, actualEndingCash) ||
                other.actualEndingCash == actualEndingCash) &&
            (identical(other.cashDropped, cashDropped) ||
                other.cashDropped == cashDropped) &&
            (identical(other.cashLeftInDrawer, cashLeftInDrawer) ||
                other.cashLeftInDrawer == cashLeftInDrawer) &&
            (identical(other.variance, variance) ||
                other.variance == variance) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    shiftId,
    status,
    openedAt,
    closedAt,
    cashierName,
    startingCash,
    cashRevenue,
    digitalRevenue,
    totalRevenue,
    expectedEndingCash,
    actualEndingCash,
    cashDropped,
    cashLeftInDrawer,
    variance,
    notes,
  );

  /// Create a copy of ShiftReportSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShiftReportSummaryImplCopyWith<_$ShiftReportSummaryImpl> get copyWith =>
      __$$ShiftReportSummaryImplCopyWithImpl<_$ShiftReportSummaryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ShiftReportSummaryImplToJson(this);
  }
}

abstract class _ShiftReportSummary extends ShiftReportSummary {
  const factory _ShiftReportSummary({
    @JsonKey(name: 'shift_id') required final int shiftId,
    final String status,
    @JsonKey(name: 'opened_at') final DateTime? openedAt,
    @JsonKey(name: 'closed_at') final DateTime? closedAt,
    @JsonKey(name: 'cashier_name') final String? cashierName,
    @JsonKey(name: 'starting_cash') final double startingCash,
    @JsonKey(name: 'cash_revenue') final double cashRevenue,
    @JsonKey(name: 'digital_revenue') final double digitalRevenue,
    @JsonKey(name: 'total_revenue') final double totalRevenue,
    @JsonKey(name: 'expected_ending_cash') final double expectedEndingCash,
    @JsonKey(name: 'actual_ending_cash') final double? actualEndingCash,
    @JsonKey(name: 'cash_dropped') final double cashDropped,
    @JsonKey(name: 'cash_left_in_drawer') final double cashLeftInDrawer,
    final double variance,
    final String? notes,
  }) = _$ShiftReportSummaryImpl;
  const _ShiftReportSummary._() : super._();

  factory _ShiftReportSummary.fromJson(Map<String, dynamic> json) =
      _$ShiftReportSummaryImpl.fromJson;

  @override
  @JsonKey(name: 'shift_id')
  int get shiftId;
  @override
  String get status;
  @override
  @JsonKey(name: 'opened_at')
  DateTime? get openedAt;
  @override
  @JsonKey(name: 'closed_at')
  DateTime? get closedAt;
  @override
  @JsonKey(name: 'cashier_name')
  String? get cashierName;
  @override
  @JsonKey(name: 'starting_cash')
  double get startingCash;
  @override
  @JsonKey(name: 'cash_revenue')
  double get cashRevenue;
  @override
  @JsonKey(name: 'digital_revenue')
  double get digitalRevenue;
  @override
  @JsonKey(name: 'total_revenue')
  double get totalRevenue;
  @override
  @JsonKey(name: 'expected_ending_cash')
  double get expectedEndingCash;
  @override
  @JsonKey(name: 'actual_ending_cash')
  double? get actualEndingCash;
  @override
  @JsonKey(name: 'cash_dropped')
  double get cashDropped;
  @override
  @JsonKey(name: 'cash_left_in_drawer')
  double get cashLeftInDrawer;
  @override
  double get variance;
  @override
  String? get notes;

  /// Create a copy of ShiftReportSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShiftReportSummaryImplCopyWith<_$ShiftReportSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
