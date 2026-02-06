// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Room _$RoomFromJson(Map<String, dynamic> json) {
  return _Room.fromJson(json);
}

/// @nodoc
mixin _$Room {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'device_type')
  DeviceType get deviceType => throw _privateConstructorUsedError;
  @JsonKey(name: 'hourly_rate')
  double get singleMatchHourlyRate => throw _privateConstructorUsedError;
  @JsonKey(name: 'multi_player_hourly_rate')
  double get multiMatchHourlyRate => throw _privateConstructorUsedError;
  @JsonKey(name: 'other_hourly_rate')
  double get otherHourlyRate => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_status')
  RoomStatus get currentStatus => throw _privateConstructorUsedError;

  /// Serializes this Room to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoomCopyWith<Room> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomCopyWith<$Res> {
  factory $RoomCopyWith(Room value, $Res Function(Room) then) =
      _$RoomCopyWithImpl<$Res, Room>;
  @useResult
  $Res call({
    int id,
    String name,
    @JsonKey(name: 'device_type') DeviceType deviceType,
    @JsonKey(name: 'hourly_rate') double singleMatchHourlyRate,
    @JsonKey(name: 'multi_player_hourly_rate') double multiMatchHourlyRate,
    @JsonKey(name: 'other_hourly_rate') double otherHourlyRate,
    @JsonKey(name: 'current_status') RoomStatus currentStatus,
  });
}

/// @nodoc
class _$RoomCopyWithImpl<$Res, $Val extends Room>
    implements $RoomCopyWith<$Res> {
  _$RoomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? deviceType = null,
    Object? singleMatchHourlyRate = null,
    Object? multiMatchHourlyRate = null,
    Object? otherHourlyRate = null,
    Object? currentStatus = null,
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
            deviceType: null == deviceType
                ? _value.deviceType
                : deviceType // ignore: cast_nullable_to_non_nullable
                      as DeviceType,
            singleMatchHourlyRate: null == singleMatchHourlyRate
                ? _value.singleMatchHourlyRate
                : singleMatchHourlyRate // ignore: cast_nullable_to_non_nullable
                      as double,
            multiMatchHourlyRate: null == multiMatchHourlyRate
                ? _value.multiMatchHourlyRate
                : multiMatchHourlyRate // ignore: cast_nullable_to_non_nullable
                      as double,
            otherHourlyRate: null == otherHourlyRate
                ? _value.otherHourlyRate
                : otherHourlyRate // ignore: cast_nullable_to_non_nullable
                      as double,
            currentStatus: null == currentStatus
                ? _value.currentStatus
                : currentStatus // ignore: cast_nullable_to_non_nullable
                      as RoomStatus,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RoomImplCopyWith<$Res> implements $RoomCopyWith<$Res> {
  factory _$$RoomImplCopyWith(
    _$RoomImpl value,
    $Res Function(_$RoomImpl) then,
  ) = __$$RoomImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    @JsonKey(name: 'device_type') DeviceType deviceType,
    @JsonKey(name: 'hourly_rate') double singleMatchHourlyRate,
    @JsonKey(name: 'multi_player_hourly_rate') double multiMatchHourlyRate,
    @JsonKey(name: 'other_hourly_rate') double otherHourlyRate,
    @JsonKey(name: 'current_status') RoomStatus currentStatus,
  });
}

/// @nodoc
class __$$RoomImplCopyWithImpl<$Res>
    extends _$RoomCopyWithImpl<$Res, _$RoomImpl>
    implements _$$RoomImplCopyWith<$Res> {
  __$$RoomImplCopyWithImpl(_$RoomImpl _value, $Res Function(_$RoomImpl) _then)
    : super(_value, _then);

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? deviceType = null,
    Object? singleMatchHourlyRate = null,
    Object? multiMatchHourlyRate = null,
    Object? otherHourlyRate = null,
    Object? currentStatus = null,
  }) {
    return _then(
      _$RoomImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        deviceType: null == deviceType
            ? _value.deviceType
            : deviceType // ignore: cast_nullable_to_non_nullable
                  as DeviceType,
        singleMatchHourlyRate: null == singleMatchHourlyRate
            ? _value.singleMatchHourlyRate
            : singleMatchHourlyRate // ignore: cast_nullable_to_non_nullable
                  as double,
        multiMatchHourlyRate: null == multiMatchHourlyRate
            ? _value.multiMatchHourlyRate
            : multiMatchHourlyRate // ignore: cast_nullable_to_non_nullable
                  as double,
        otherHourlyRate: null == otherHourlyRate
            ? _value.otherHourlyRate
            : otherHourlyRate // ignore: cast_nullable_to_non_nullable
                  as double,
        currentStatus: null == currentStatus
            ? _value.currentStatus
            : currentStatus // ignore: cast_nullable_to_non_nullable
                  as RoomStatus,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RoomImpl implements _Room {
  const _$RoomImpl({
    required this.id,
    required this.name,
    @JsonKey(name: 'device_type') required this.deviceType,
    @JsonKey(name: 'hourly_rate') required this.singleMatchHourlyRate,
    @JsonKey(name: 'multi_player_hourly_rate')
    required this.multiMatchHourlyRate,
    @JsonKey(name: 'other_hourly_rate') required this.otherHourlyRate,
    @JsonKey(name: 'current_status') required this.currentStatus,
  });

  factory _$RoomImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  @JsonKey(name: 'device_type')
  final DeviceType deviceType;
  @override
  @JsonKey(name: 'hourly_rate')
  final double singleMatchHourlyRate;
  @override
  @JsonKey(name: 'multi_player_hourly_rate')
  final double multiMatchHourlyRate;
  @override
  @JsonKey(name: 'other_hourly_rate')
  final double otherHourlyRate;
  @override
  @JsonKey(name: 'current_status')
  final RoomStatus currentStatus;

  @override
  String toString() {
    return 'Room(id: $id, name: $name, deviceType: $deviceType, singleMatchHourlyRate: $singleMatchHourlyRate, multiMatchHourlyRate: $multiMatchHourlyRate, otherHourlyRate: $otherHourlyRate, currentStatus: $currentStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.deviceType, deviceType) ||
                other.deviceType == deviceType) &&
            (identical(other.singleMatchHourlyRate, singleMatchHourlyRate) ||
                other.singleMatchHourlyRate == singleMatchHourlyRate) &&
            (identical(other.multiMatchHourlyRate, multiMatchHourlyRate) ||
                other.multiMatchHourlyRate == multiMatchHourlyRate) &&
            (identical(other.otherHourlyRate, otherHourlyRate) ||
                other.otherHourlyRate == otherHourlyRate) &&
            (identical(other.currentStatus, currentStatus) ||
                other.currentStatus == currentStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    deviceType,
    singleMatchHourlyRate,
    multiMatchHourlyRate,
    otherHourlyRate,
    currentStatus,
  );

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomImplCopyWith<_$RoomImpl> get copyWith =>
      __$$RoomImplCopyWithImpl<_$RoomImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomImplToJson(this);
  }
}

abstract class _Room implements Room {
  const factory _Room({
    required final int id,
    required final String name,
    @JsonKey(name: 'device_type') required final DeviceType deviceType,
    @JsonKey(name: 'hourly_rate') required final double singleMatchHourlyRate,
    @JsonKey(name: 'multi_player_hourly_rate')
    required final double multiMatchHourlyRate,
    @JsonKey(name: 'other_hourly_rate') required final double otherHourlyRate,
    @JsonKey(name: 'current_status') required final RoomStatus currentStatus,
  }) = _$RoomImpl;

  factory _Room.fromJson(Map<String, dynamic> json) = _$RoomImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'device_type')
  DeviceType get deviceType;
  @override
  @JsonKey(name: 'hourly_rate')
  double get singleMatchHourlyRate;
  @override
  @JsonKey(name: 'multi_player_hourly_rate')
  double get multiMatchHourlyRate;
  @override
  @JsonKey(name: 'other_hourly_rate')
  double get otherHourlyRate;
  @override
  @JsonKey(name: 'current_status')
  RoomStatus get currentStatus;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomImplCopyWith<_$RoomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
