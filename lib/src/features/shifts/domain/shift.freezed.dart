// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shift.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Shift _$ShiftFromJson(Map<String, dynamic> json) {
  return _Shift.fromJson(json);
}

/// @nodoc
mixin _$Shift {
  @JsonKey(includeToJson: false)
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'cashier_id')
  int get cashierId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'opened_at')
  DateTime? get openedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'starting_cash')
  double get startingCash => throw _privateConstructorUsedError;
  @JsonKey(name: 'actual_ending_cash')
  double? get actualEndingCash => throw _privateConstructorUsedError;
  @JsonKey(name: 'cash_dropped')
  double? get cashDropped => throw _privateConstructorUsedError;
  @JsonKey(name: 'cash_left_in_drawer')
  double? get cashLeftInDrawer => throw _privateConstructorUsedError; // Joined field — populated when fetching with cashier join
  @JsonKey(name: 'cashier_name')
  String? get cashierName => throw _privateConstructorUsedError;

  /// Serializes this Shift to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Shift
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShiftCopyWith<Shift> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShiftCopyWith<$Res> {
  factory $ShiftCopyWith(Shift value, $Res Function(Shift) then) =
      _$ShiftCopyWithImpl<$Res, Shift>;
  @useResult
  $Res call({
    @JsonKey(includeToJson: false) int? id,
    @JsonKey(name: 'cashier_id') int cashierId,
    String status,
    @JsonKey(name: 'opened_at') DateTime? openedAt,
    @JsonKey(name: 'starting_cash') double startingCash,
    @JsonKey(name: 'actual_ending_cash') double? actualEndingCash,
    @JsonKey(name: 'cash_dropped') double? cashDropped,
    @JsonKey(name: 'cash_left_in_drawer') double? cashLeftInDrawer,
    @JsonKey(name: 'cashier_name') String? cashierName,
  });
}

/// @nodoc
class _$ShiftCopyWithImpl<$Res, $Val extends Shift>
    implements $ShiftCopyWith<$Res> {
  _$ShiftCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Shift
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? cashierId = null,
    Object? status = null,
    Object? openedAt = freezed,
    Object? startingCash = null,
    Object? actualEndingCash = freezed,
    Object? cashDropped = freezed,
    Object? cashLeftInDrawer = freezed,
    Object? cashierName = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int?,
            cashierId: null == cashierId
                ? _value.cashierId
                : cashierId // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            openedAt: freezed == openedAt
                ? _value.openedAt
                : openedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            startingCash: null == startingCash
                ? _value.startingCash
                : startingCash // ignore: cast_nullable_to_non_nullable
                      as double,
            actualEndingCash: freezed == actualEndingCash
                ? _value.actualEndingCash
                : actualEndingCash // ignore: cast_nullable_to_non_nullable
                      as double?,
            cashDropped: freezed == cashDropped
                ? _value.cashDropped
                : cashDropped // ignore: cast_nullable_to_non_nullable
                      as double?,
            cashLeftInDrawer: freezed == cashLeftInDrawer
                ? _value.cashLeftInDrawer
                : cashLeftInDrawer // ignore: cast_nullable_to_non_nullable
                      as double?,
            cashierName: freezed == cashierName
                ? _value.cashierName
                : cashierName // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ShiftImplCopyWith<$Res> implements $ShiftCopyWith<$Res> {
  factory _$$ShiftImplCopyWith(
    _$ShiftImpl value,
    $Res Function(_$ShiftImpl) then,
  ) = __$$ShiftImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(includeToJson: false) int? id,
    @JsonKey(name: 'cashier_id') int cashierId,
    String status,
    @JsonKey(name: 'opened_at') DateTime? openedAt,
    @JsonKey(name: 'starting_cash') double startingCash,
    @JsonKey(name: 'actual_ending_cash') double? actualEndingCash,
    @JsonKey(name: 'cash_dropped') double? cashDropped,
    @JsonKey(name: 'cash_left_in_drawer') double? cashLeftInDrawer,
    @JsonKey(name: 'cashier_name') String? cashierName,
  });
}

/// @nodoc
class __$$ShiftImplCopyWithImpl<$Res>
    extends _$ShiftCopyWithImpl<$Res, _$ShiftImpl>
    implements _$$ShiftImplCopyWith<$Res> {
  __$$ShiftImplCopyWithImpl(
    _$ShiftImpl _value,
    $Res Function(_$ShiftImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Shift
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? cashierId = null,
    Object? status = null,
    Object? openedAt = freezed,
    Object? startingCash = null,
    Object? actualEndingCash = freezed,
    Object? cashDropped = freezed,
    Object? cashLeftInDrawer = freezed,
    Object? cashierName = freezed,
  }) {
    return _then(
      _$ShiftImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        cashierId: null == cashierId
            ? _value.cashierId
            : cashierId // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        openedAt: freezed == openedAt
            ? _value.openedAt
            : openedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        startingCash: null == startingCash
            ? _value.startingCash
            : startingCash // ignore: cast_nullable_to_non_nullable
                  as double,
        actualEndingCash: freezed == actualEndingCash
            ? _value.actualEndingCash
            : actualEndingCash // ignore: cast_nullable_to_non_nullable
                  as double?,
        cashDropped: freezed == cashDropped
            ? _value.cashDropped
            : cashDropped // ignore: cast_nullable_to_non_nullable
                  as double?,
        cashLeftInDrawer: freezed == cashLeftInDrawer
            ? _value.cashLeftInDrawer
            : cashLeftInDrawer // ignore: cast_nullable_to_non_nullable
                  as double?,
        cashierName: freezed == cashierName
            ? _value.cashierName
            : cashierName // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ShiftImpl extends _Shift {
  const _$ShiftImpl({
    @JsonKey(includeToJson: false) this.id,
    @JsonKey(name: 'cashier_id') required this.cashierId,
    this.status = 'open',
    @JsonKey(name: 'opened_at') this.openedAt,
    @JsonKey(name: 'starting_cash') this.startingCash = 0.0,
    @JsonKey(name: 'actual_ending_cash') this.actualEndingCash,
    @JsonKey(name: 'cash_dropped') this.cashDropped,
    @JsonKey(name: 'cash_left_in_drawer') this.cashLeftInDrawer,
    @JsonKey(name: 'cashier_name') this.cashierName,
  }) : super._();

  factory _$ShiftImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShiftImplFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final int? id;
  @override
  @JsonKey(name: 'cashier_id')
  final int cashierId;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey(name: 'opened_at')
  final DateTime? openedAt;
  @override
  @JsonKey(name: 'starting_cash')
  final double startingCash;
  @override
  @JsonKey(name: 'actual_ending_cash')
  final double? actualEndingCash;
  @override
  @JsonKey(name: 'cash_dropped')
  final double? cashDropped;
  @override
  @JsonKey(name: 'cash_left_in_drawer')
  final double? cashLeftInDrawer;
  // Joined field — populated when fetching with cashier join
  @override
  @JsonKey(name: 'cashier_name')
  final String? cashierName;

  @override
  String toString() {
    return 'Shift(id: $id, cashierId: $cashierId, status: $status, openedAt: $openedAt, startingCash: $startingCash, actualEndingCash: $actualEndingCash, cashDropped: $cashDropped, cashLeftInDrawer: $cashLeftInDrawer, cashierName: $cashierName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShiftImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.cashierId, cashierId) ||
                other.cashierId == cashierId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.openedAt, openedAt) ||
                other.openedAt == openedAt) &&
            (identical(other.startingCash, startingCash) ||
                other.startingCash == startingCash) &&
            (identical(other.actualEndingCash, actualEndingCash) ||
                other.actualEndingCash == actualEndingCash) &&
            (identical(other.cashDropped, cashDropped) ||
                other.cashDropped == cashDropped) &&
            (identical(other.cashLeftInDrawer, cashLeftInDrawer) ||
                other.cashLeftInDrawer == cashLeftInDrawer) &&
            (identical(other.cashierName, cashierName) ||
                other.cashierName == cashierName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    cashierId,
    status,
    openedAt,
    startingCash,
    actualEndingCash,
    cashDropped,
    cashLeftInDrawer,
    cashierName,
  );

  /// Create a copy of Shift
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShiftImplCopyWith<_$ShiftImpl> get copyWith =>
      __$$ShiftImplCopyWithImpl<_$ShiftImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShiftImplToJson(this);
  }
}

abstract class _Shift extends Shift {
  const factory _Shift({
    @JsonKey(includeToJson: false) final int? id,
    @JsonKey(name: 'cashier_id') required final int cashierId,
    final String status,
    @JsonKey(name: 'opened_at') final DateTime? openedAt,
    @JsonKey(name: 'starting_cash') final double startingCash,
    @JsonKey(name: 'actual_ending_cash') final double? actualEndingCash,
    @JsonKey(name: 'cash_dropped') final double? cashDropped,
    @JsonKey(name: 'cash_left_in_drawer') final double? cashLeftInDrawer,
    @JsonKey(name: 'cashier_name') final String? cashierName,
  }) = _$ShiftImpl;
  const _Shift._() : super._();

  factory _Shift.fromJson(Map<String, dynamic> json) = _$ShiftImpl.fromJson;

  @override
  @JsonKey(includeToJson: false)
  int? get id;
  @override
  @JsonKey(name: 'cashier_id')
  int get cashierId;
  @override
  String get status;
  @override
  @JsonKey(name: 'opened_at')
  DateTime? get openedAt;
  @override
  @JsonKey(name: 'starting_cash')
  double get startingCash;
  @override
  @JsonKey(name: 'actual_ending_cash')
  double? get actualEndingCash;
  @override
  @JsonKey(name: 'cash_dropped')
  double? get cashDropped;
  @override
  @JsonKey(name: 'cash_left_in_drawer')
  double? get cashLeftInDrawer; // Joined field — populated when fetching with cashier join
  @override
  @JsonKey(name: 'cashier_name')
  String? get cashierName;

  /// Create a copy of Shift
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShiftImplCopyWith<_$ShiftImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
