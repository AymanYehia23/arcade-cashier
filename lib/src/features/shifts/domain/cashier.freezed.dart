// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cashier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Cashier _$CashierFromJson(Map<String, dynamic> json) {
  return _Cashier.fromJson(json);
}

/// @nodoc
mixin _$Cashier {
  @JsonKey(includeToJson: false)
  int? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'pin_code')
  String get pinCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this Cashier to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Cashier
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CashierCopyWith<Cashier> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CashierCopyWith<$Res> {
  factory $CashierCopyWith(Cashier value, $Res Function(Cashier) then) =
      _$CashierCopyWithImpl<$Res, Cashier>;
  @useResult
  $Res call({
    @JsonKey(includeToJson: false) int? id,
    String name,
    @JsonKey(name: 'pin_code') String pinCode,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class _$CashierCopyWithImpl<$Res, $Val extends Cashier>
    implements $CashierCopyWith<$Res> {
  _$CashierCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Cashier
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? pinCode = null,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int?,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            pinCode: null == pinCode
                ? _value.pinCode
                : pinCode // ignore: cast_nullable_to_non_nullable
                      as String,
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
abstract class _$$CashierImplCopyWith<$Res> implements $CashierCopyWith<$Res> {
  factory _$$CashierImplCopyWith(
    _$CashierImpl value,
    $Res Function(_$CashierImpl) then,
  ) = __$$CashierImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(includeToJson: false) int? id,
    String name,
    @JsonKey(name: 'pin_code') String pinCode,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class __$$CashierImplCopyWithImpl<$Res>
    extends _$CashierCopyWithImpl<$Res, _$CashierImpl>
    implements _$$CashierImplCopyWith<$Res> {
  __$$CashierImplCopyWithImpl(
    _$CashierImpl _value,
    $Res Function(_$CashierImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Cashier
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? pinCode = null,
    Object? isActive = null,
  }) {
    return _then(
      _$CashierImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        pinCode: null == pinCode
            ? _value.pinCode
            : pinCode // ignore: cast_nullable_to_non_nullable
                  as String,
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
class _$CashierImpl extends _Cashier {
  const _$CashierImpl({
    @JsonKey(includeToJson: false) this.id,
    required this.name,
    @JsonKey(name: 'pin_code') required this.pinCode,
    @JsonKey(name: 'is_active') this.isActive = true,
  }) : super._();

  factory _$CashierImpl.fromJson(Map<String, dynamic> json) =>
      _$$CashierImplFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final int? id;
  @override
  final String name;
  @override
  @JsonKey(name: 'pin_code')
  final String pinCode;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;

  @override
  String toString() {
    return 'Cashier(id: $id, name: $name, pinCode: $pinCode, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CashierImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.pinCode, pinCode) || other.pinCode == pinCode) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, pinCode, isActive);

  /// Create a copy of Cashier
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CashierImplCopyWith<_$CashierImpl> get copyWith =>
      __$$CashierImplCopyWithImpl<_$CashierImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CashierImplToJson(this);
  }
}

abstract class _Cashier extends Cashier {
  const factory _Cashier({
    @JsonKey(includeToJson: false) final int? id,
    required final String name,
    @JsonKey(name: 'pin_code') required final String pinCode,
    @JsonKey(name: 'is_active') final bool isActive,
  }) = _$CashierImpl;
  const _Cashier._() : super._();

  factory _Cashier.fromJson(Map<String, dynamic> json) = _$CashierImpl.fromJson;

  @override
  @JsonKey(includeToJson: false)
  int? get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'pin_code')
  String get pinCode;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;

  /// Create a copy of Cashier
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CashierImplCopyWith<_$CashierImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
