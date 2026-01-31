// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Session _$SessionFromJson(Map<String, dynamic> json) {
  return _Session.fromJson(json);
}

/// @nodoc
mixin _$Session {
  int get id => throw _privateConstructorUsedError;
  int get roomId => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime? get endTime => throw _privateConstructorUsedError;
  double get appliedHourlyRate => throw _privateConstructorUsedError;
  bool get isMultiMatch => throw _privateConstructorUsedError;
  SessionType get sessionType => throw _privateConstructorUsedError;
  int? get plannedDurationMinutes => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  SessionStatus get status => throw _privateConstructorUsedError;

  /// Serializes this Session to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionCopyWith<Session> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionCopyWith<$Res> {
  factory $SessionCopyWith(Session value, $Res Function(Session) then) =
      _$SessionCopyWithImpl<$Res, Session>;
  @useResult
  $Res call({
    int id,
    int roomId,
    DateTime startTime,
    DateTime? endTime,
    double appliedHourlyRate,
    bool isMultiMatch,
    SessionType sessionType,
    int? plannedDurationMinutes,
    String source,
    SessionStatus status,
  });
}

/// @nodoc
class _$SessionCopyWithImpl<$Res, $Val extends Session>
    implements $SessionCopyWith<$Res> {
  _$SessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomId = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? appliedHourlyRate = null,
    Object? isMultiMatch = null,
    Object? sessionType = null,
    Object? plannedDurationMinutes = freezed,
    Object? source = null,
    Object? status = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            roomId: null == roomId
                ? _value.roomId
                : roomId // ignore: cast_nullable_to_non_nullable
                      as int,
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endTime: freezed == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            appliedHourlyRate: null == appliedHourlyRate
                ? _value.appliedHourlyRate
                : appliedHourlyRate // ignore: cast_nullable_to_non_nullable
                      as double,
            isMultiMatch: null == isMultiMatch
                ? _value.isMultiMatch
                : isMultiMatch // ignore: cast_nullable_to_non_nullable
                      as bool,
            sessionType: null == sessionType
                ? _value.sessionType
                : sessionType // ignore: cast_nullable_to_non_nullable
                      as SessionType,
            plannedDurationMinutes: freezed == plannedDurationMinutes
                ? _value.plannedDurationMinutes
                : plannedDurationMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
            source: null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as SessionStatus,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SessionImplCopyWith<$Res> implements $SessionCopyWith<$Res> {
  factory _$$SessionImplCopyWith(
    _$SessionImpl value,
    $Res Function(_$SessionImpl) then,
  ) = __$$SessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int roomId,
    DateTime startTime,
    DateTime? endTime,
    double appliedHourlyRate,
    bool isMultiMatch,
    SessionType sessionType,
    int? plannedDurationMinutes,
    String source,
    SessionStatus status,
  });
}

/// @nodoc
class __$$SessionImplCopyWithImpl<$Res>
    extends _$SessionCopyWithImpl<$Res, _$SessionImpl>
    implements _$$SessionImplCopyWith<$Res> {
  __$$SessionImplCopyWithImpl(
    _$SessionImpl _value,
    $Res Function(_$SessionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomId = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? appliedHourlyRate = null,
    Object? isMultiMatch = null,
    Object? sessionType = null,
    Object? plannedDurationMinutes = freezed,
    Object? source = null,
    Object? status = null,
  }) {
    return _then(
      _$SessionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        roomId: null == roomId
            ? _value.roomId
            : roomId // ignore: cast_nullable_to_non_nullable
                  as int,
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endTime: freezed == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        appliedHourlyRate: null == appliedHourlyRate
            ? _value.appliedHourlyRate
            : appliedHourlyRate // ignore: cast_nullable_to_non_nullable
                  as double,
        isMultiMatch: null == isMultiMatch
            ? _value.isMultiMatch
            : isMultiMatch // ignore: cast_nullable_to_non_nullable
                  as bool,
        sessionType: null == sessionType
            ? _value.sessionType
            : sessionType // ignore: cast_nullable_to_non_nullable
                  as SessionType,
        plannedDurationMinutes: freezed == plannedDurationMinutes
            ? _value.plannedDurationMinutes
            : plannedDurationMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as SessionStatus,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionImpl implements _Session {
  const _$SessionImpl({
    required this.id,
    required this.roomId,
    required this.startTime,
    this.endTime,
    required this.appliedHourlyRate,
    required this.isMultiMatch,
    this.sessionType = SessionType.open,
    this.plannedDurationMinutes,
    this.source = 'walk_in',
    this.status = SessionStatus.active,
  });

  factory _$SessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionImplFromJson(json);

  @override
  final int id;
  @override
  final int roomId;
  @override
  final DateTime startTime;
  @override
  final DateTime? endTime;
  @override
  final double appliedHourlyRate;
  @override
  final bool isMultiMatch;
  @override
  @JsonKey()
  final SessionType sessionType;
  @override
  final int? plannedDurationMinutes;
  @override
  @JsonKey()
  final String source;
  @override
  @JsonKey()
  final SessionStatus status;

  @override
  String toString() {
    return 'Session(id: $id, roomId: $roomId, startTime: $startTime, endTime: $endTime, appliedHourlyRate: $appliedHourlyRate, isMultiMatch: $isMultiMatch, sessionType: $sessionType, plannedDurationMinutes: $plannedDurationMinutes, source: $source, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.appliedHourlyRate, appliedHourlyRate) ||
                other.appliedHourlyRate == appliedHourlyRate) &&
            (identical(other.isMultiMatch, isMultiMatch) ||
                other.isMultiMatch == isMultiMatch) &&
            (identical(other.sessionType, sessionType) ||
                other.sessionType == sessionType) &&
            (identical(other.plannedDurationMinutes, plannedDurationMinutes) ||
                other.plannedDurationMinutes == plannedDurationMinutes) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    roomId,
    startTime,
    endTime,
    appliedHourlyRate,
    isMultiMatch,
    sessionType,
    plannedDurationMinutes,
    source,
    status,
  );

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionImplCopyWith<_$SessionImpl> get copyWith =>
      __$$SessionImplCopyWithImpl<_$SessionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionImplToJson(this);
  }
}

abstract class _Session implements Session {
  const factory _Session({
    required final int id,
    required final int roomId,
    required final DateTime startTime,
    final DateTime? endTime,
    required final double appliedHourlyRate,
    required final bool isMultiMatch,
    final SessionType sessionType,
    final int? plannedDurationMinutes,
    final String source,
    final SessionStatus status,
  }) = _$SessionImpl;

  factory _Session.fromJson(Map<String, dynamic> json) = _$SessionImpl.fromJson;

  @override
  int get id;
  @override
  int get roomId;
  @override
  DateTime get startTime;
  @override
  DateTime? get endTime;
  @override
  double get appliedHourlyRate;
  @override
  bool get isMultiMatch;
  @override
  SessionType get sessionType;
  @override
  int? get plannedDurationMinutes;
  @override
  String get source;
  @override
  SessionStatus get status;

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionImplCopyWith<_$SessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
