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
  @JsonKey(name: 'room_id')
  int? get roomId => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_time')
  DateTime get startTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_time')
  DateTime? get endTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'applied_hourly_rate')
  double get appliedHourlyRate => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_multi_match')
  bool get isMultiMatch => throw _privateConstructorUsedError;
  @JsonKey(name: 'session_type')
  SessionType get sessionType => throw _privateConstructorUsedError;
  @JsonKey(name: 'planned_duration_minutes')
  int? get plannedDurationMinutes => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  SessionStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'paused_at')
  DateTime? get pausedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_paused_duration_seconds')
  int get totalPausedDurationSeconds => throw _privateConstructorUsedError;

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
    @JsonKey(name: 'room_id') int? roomId,
    @JsonKey(name: 'start_time') DateTime startTime,
    @JsonKey(name: 'end_time') DateTime? endTime,
    @JsonKey(name: 'applied_hourly_rate') double appliedHourlyRate,
    @JsonKey(name: 'is_multi_match') bool isMultiMatch,
    @JsonKey(name: 'session_type') SessionType sessionType,
    @JsonKey(name: 'planned_duration_minutes') int? plannedDurationMinutes,
    String source,
    SessionStatus status,
    @JsonKey(name: 'paused_at') DateTime? pausedAt,
    @JsonKey(name: 'total_paused_duration_seconds')
    int totalPausedDurationSeconds,
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
    Object? roomId = freezed,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? appliedHourlyRate = null,
    Object? isMultiMatch = null,
    Object? sessionType = null,
    Object? plannedDurationMinutes = freezed,
    Object? source = null,
    Object? status = null,
    Object? pausedAt = freezed,
    Object? totalPausedDurationSeconds = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            roomId: freezed == roomId
                ? _value.roomId
                : roomId // ignore: cast_nullable_to_non_nullable
                      as int?,
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
            pausedAt: freezed == pausedAt
                ? _value.pausedAt
                : pausedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            totalPausedDurationSeconds: null == totalPausedDurationSeconds
                ? _value.totalPausedDurationSeconds
                : totalPausedDurationSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
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
    @JsonKey(name: 'room_id') int? roomId,
    @JsonKey(name: 'start_time') DateTime startTime,
    @JsonKey(name: 'end_time') DateTime? endTime,
    @JsonKey(name: 'applied_hourly_rate') double appliedHourlyRate,
    @JsonKey(name: 'is_multi_match') bool isMultiMatch,
    @JsonKey(name: 'session_type') SessionType sessionType,
    @JsonKey(name: 'planned_duration_minutes') int? plannedDurationMinutes,
    String source,
    SessionStatus status,
    @JsonKey(name: 'paused_at') DateTime? pausedAt,
    @JsonKey(name: 'total_paused_duration_seconds')
    int totalPausedDurationSeconds,
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
    Object? roomId = freezed,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? appliedHourlyRate = null,
    Object? isMultiMatch = null,
    Object? sessionType = null,
    Object? plannedDurationMinutes = freezed,
    Object? source = null,
    Object? status = null,
    Object? pausedAt = freezed,
    Object? totalPausedDurationSeconds = null,
  }) {
    return _then(
      _$SessionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        roomId: freezed == roomId
            ? _value.roomId
            : roomId // ignore: cast_nullable_to_non_nullable
                  as int?,
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
        pausedAt: freezed == pausedAt
            ? _value.pausedAt
            : pausedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        totalPausedDurationSeconds: null == totalPausedDurationSeconds
            ? _value.totalPausedDurationSeconds
            : totalPausedDurationSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionImpl extends _Session {
  const _$SessionImpl({
    required this.id,
    @JsonKey(name: 'room_id') this.roomId,
    @JsonKey(name: 'start_time') required this.startTime,
    @JsonKey(name: 'end_time') this.endTime,
    @JsonKey(name: 'applied_hourly_rate') required this.appliedHourlyRate,
    @JsonKey(name: 'is_multi_match') required this.isMultiMatch,
    @JsonKey(name: 'session_type') this.sessionType = SessionType.open,
    @JsonKey(name: 'planned_duration_minutes') this.plannedDurationMinutes,
    this.source = 'walk_in',
    this.status = SessionStatus.active,
    @JsonKey(name: 'paused_at') this.pausedAt,
    @JsonKey(name: 'total_paused_duration_seconds')
    this.totalPausedDurationSeconds = 0,
  }) : super._();

  factory _$SessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'room_id')
  final int? roomId;
  @override
  @JsonKey(name: 'start_time')
  final DateTime startTime;
  @override
  @JsonKey(name: 'end_time')
  final DateTime? endTime;
  @override
  @JsonKey(name: 'applied_hourly_rate')
  final double appliedHourlyRate;
  @override
  @JsonKey(name: 'is_multi_match')
  final bool isMultiMatch;
  @override
  @JsonKey(name: 'session_type')
  final SessionType sessionType;
  @override
  @JsonKey(name: 'planned_duration_minutes')
  final int? plannedDurationMinutes;
  @override
  @JsonKey()
  final String source;
  @override
  @JsonKey()
  final SessionStatus status;
  @override
  @JsonKey(name: 'paused_at')
  final DateTime? pausedAt;
  @override
  @JsonKey(name: 'total_paused_duration_seconds')
  final int totalPausedDurationSeconds;

  @override
  String toString() {
    return 'Session(id: $id, roomId: $roomId, startTime: $startTime, endTime: $endTime, appliedHourlyRate: $appliedHourlyRate, isMultiMatch: $isMultiMatch, sessionType: $sessionType, plannedDurationMinutes: $plannedDurationMinutes, source: $source, status: $status, pausedAt: $pausedAt, totalPausedDurationSeconds: $totalPausedDurationSeconds)';
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
            (identical(other.status, status) || other.status == status) &&
            (identical(other.pausedAt, pausedAt) ||
                other.pausedAt == pausedAt) &&
            (identical(
                  other.totalPausedDurationSeconds,
                  totalPausedDurationSeconds,
                ) ||
                other.totalPausedDurationSeconds ==
                    totalPausedDurationSeconds));
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
    pausedAt,
    totalPausedDurationSeconds,
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

abstract class _Session extends Session {
  const factory _Session({
    required final int id,
    @JsonKey(name: 'room_id') final int? roomId,
    @JsonKey(name: 'start_time') required final DateTime startTime,
    @JsonKey(name: 'end_time') final DateTime? endTime,
    @JsonKey(name: 'applied_hourly_rate')
    required final double appliedHourlyRate,
    @JsonKey(name: 'is_multi_match') required final bool isMultiMatch,
    @JsonKey(name: 'session_type') final SessionType sessionType,
    @JsonKey(name: 'planned_duration_minutes')
    final int? plannedDurationMinutes,
    final String source,
    final SessionStatus status,
    @JsonKey(name: 'paused_at') final DateTime? pausedAt,
    @JsonKey(name: 'total_paused_duration_seconds')
    final int totalPausedDurationSeconds,
  }) = _$SessionImpl;
  const _Session._() : super._();

  factory _Session.fromJson(Map<String, dynamic> json) = _$SessionImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'room_id')
  int? get roomId;
  @override
  @JsonKey(name: 'start_time')
  DateTime get startTime;
  @override
  @JsonKey(name: 'end_time')
  DateTime? get endTime;
  @override
  @JsonKey(name: 'applied_hourly_rate')
  double get appliedHourlyRate;
  @override
  @JsonKey(name: 'is_multi_match')
  bool get isMultiMatch;
  @override
  @JsonKey(name: 'session_type')
  SessionType get sessionType;
  @override
  @JsonKey(name: 'planned_duration_minutes')
  int? get plannedDurationMinutes;
  @override
  String get source;
  @override
  SessionStatus get status;
  @override
  @JsonKey(name: 'paused_at')
  DateTime? get pausedAt;
  @override
  @JsonKey(name: 'total_paused_duration_seconds')
  int get totalPausedDurationSeconds;

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionImplCopyWith<_$SessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
