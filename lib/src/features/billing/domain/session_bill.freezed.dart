// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_bill.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SessionBill {
  double get timeCost => throw _privateConstructorUsedError;
  double get ordersTotal => throw _privateConstructorUsedError;
  double get totalAmount => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;

  /// Create a copy of SessionBill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionBillCopyWith<SessionBill> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionBillCopyWith<$Res> {
  factory $SessionBillCopyWith(
    SessionBill value,
    $Res Function(SessionBill) then,
  ) = _$SessionBillCopyWithImpl<$Res, SessionBill>;
  @useResult
  $Res call({
    double timeCost,
    double ordersTotal,
    double totalAmount,
    Duration duration,
  });
}

/// @nodoc
class _$SessionBillCopyWithImpl<$Res, $Val extends SessionBill>
    implements $SessionBillCopyWith<$Res> {
  _$SessionBillCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionBill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timeCost = null,
    Object? ordersTotal = null,
    Object? totalAmount = null,
    Object? duration = null,
  }) {
    return _then(
      _value.copyWith(
            timeCost: null == timeCost
                ? _value.timeCost
                : timeCost // ignore: cast_nullable_to_non_nullable
                      as double,
            ordersTotal: null == ordersTotal
                ? _value.ordersTotal
                : ordersTotal // ignore: cast_nullable_to_non_nullable
                      as double,
            totalAmount: null == totalAmount
                ? _value.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            duration: null == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as Duration,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SessionBillImplCopyWith<$Res>
    implements $SessionBillCopyWith<$Res> {
  factory _$$SessionBillImplCopyWith(
    _$SessionBillImpl value,
    $Res Function(_$SessionBillImpl) then,
  ) = __$$SessionBillImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double timeCost,
    double ordersTotal,
    double totalAmount,
    Duration duration,
  });
}

/// @nodoc
class __$$SessionBillImplCopyWithImpl<$Res>
    extends _$SessionBillCopyWithImpl<$Res, _$SessionBillImpl>
    implements _$$SessionBillImplCopyWith<$Res> {
  __$$SessionBillImplCopyWithImpl(
    _$SessionBillImpl _value,
    $Res Function(_$SessionBillImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SessionBill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timeCost = null,
    Object? ordersTotal = null,
    Object? totalAmount = null,
    Object? duration = null,
  }) {
    return _then(
      _$SessionBillImpl(
        timeCost: null == timeCost
            ? _value.timeCost
            : timeCost // ignore: cast_nullable_to_non_nullable
                  as double,
        ordersTotal: null == ordersTotal
            ? _value.ordersTotal
            : ordersTotal // ignore: cast_nullable_to_non_nullable
                  as double,
        totalAmount: null == totalAmount
            ? _value.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        duration: null == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as Duration,
      ),
    );
  }
}

/// @nodoc

class _$SessionBillImpl implements _SessionBill {
  const _$SessionBillImpl({
    required this.timeCost,
    required this.ordersTotal,
    required this.totalAmount,
    required this.duration,
  });

  @override
  final double timeCost;
  @override
  final double ordersTotal;
  @override
  final double totalAmount;
  @override
  final Duration duration;

  @override
  String toString() {
    return 'SessionBill(timeCost: $timeCost, ordersTotal: $ordersTotal, totalAmount: $totalAmount, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionBillImpl &&
            (identical(other.timeCost, timeCost) ||
                other.timeCost == timeCost) &&
            (identical(other.ordersTotal, ordersTotal) ||
                other.ordersTotal == ordersTotal) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, timeCost, ordersTotal, totalAmount, duration);

  /// Create a copy of SessionBill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionBillImplCopyWith<_$SessionBillImpl> get copyWith =>
      __$$SessionBillImplCopyWithImpl<_$SessionBillImpl>(this, _$identity);
}

abstract class _SessionBill implements SessionBill {
  const factory _SessionBill({
    required final double timeCost,
    required final double ordersTotal,
    required final double totalAmount,
    required final Duration duration,
  }) = _$SessionBillImpl;

  @override
  double get timeCost;
  @override
  double get ordersTotal;
  @override
  double get totalAmount;
  @override
  Duration get duration;

  /// Create a copy of SessionBill
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionBillImplCopyWith<_$SessionBillImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
