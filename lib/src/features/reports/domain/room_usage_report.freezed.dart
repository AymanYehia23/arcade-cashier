// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_usage_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RoomUsageReport _$RoomUsageReportFromJson(Map<String, dynamic> json) {
  return _RoomUsageReport.fromJson(json);
}

/// @nodoc
mixin _$RoomUsageReport {
  @JsonKey(name: 'room_name')
  String get roomName => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_sessions')
  int get sessions => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_hours')
  double get totalHours => throw _privateConstructorUsedError;

  /// Serializes this RoomUsageReport to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RoomUsageReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoomUsageReportCopyWith<RoomUsageReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomUsageReportCopyWith<$Res> {
  factory $RoomUsageReportCopyWith(
    RoomUsageReport value,
    $Res Function(RoomUsageReport) then,
  ) = _$RoomUsageReportCopyWithImpl<$Res, RoomUsageReport>;
  @useResult
  $Res call({
    @JsonKey(name: 'room_name') String roomName,
    @JsonKey(name: 'total_sessions') int sessions,
    @JsonKey(name: 'total_hours') double totalHours,
  });
}

/// @nodoc
class _$RoomUsageReportCopyWithImpl<$Res, $Val extends RoomUsageReport>
    implements $RoomUsageReportCopyWith<$Res> {
  _$RoomUsageReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoomUsageReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roomName = null,
    Object? sessions = null,
    Object? totalHours = null,
  }) {
    return _then(
      _value.copyWith(
            roomName: null == roomName
                ? _value.roomName
                : roomName // ignore: cast_nullable_to_non_nullable
                      as String,
            sessions: null == sessions
                ? _value.sessions
                : sessions // ignore: cast_nullable_to_non_nullable
                      as int,
            totalHours: null == totalHours
                ? _value.totalHours
                : totalHours // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RoomUsageReportImplCopyWith<$Res>
    implements $RoomUsageReportCopyWith<$Res> {
  factory _$$RoomUsageReportImplCopyWith(
    _$RoomUsageReportImpl value,
    $Res Function(_$RoomUsageReportImpl) then,
  ) = __$$RoomUsageReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'room_name') String roomName,
    @JsonKey(name: 'total_sessions') int sessions,
    @JsonKey(name: 'total_hours') double totalHours,
  });
}

/// @nodoc
class __$$RoomUsageReportImplCopyWithImpl<$Res>
    extends _$RoomUsageReportCopyWithImpl<$Res, _$RoomUsageReportImpl>
    implements _$$RoomUsageReportImplCopyWith<$Res> {
  __$$RoomUsageReportImplCopyWithImpl(
    _$RoomUsageReportImpl _value,
    $Res Function(_$RoomUsageReportImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RoomUsageReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roomName = null,
    Object? sessions = null,
    Object? totalHours = null,
  }) {
    return _then(
      _$RoomUsageReportImpl(
        roomName: null == roomName
            ? _value.roomName
            : roomName // ignore: cast_nullable_to_non_nullable
                  as String,
        sessions: null == sessions
            ? _value.sessions
            : sessions // ignore: cast_nullable_to_non_nullable
                  as int,
        totalHours: null == totalHours
            ? _value.totalHours
            : totalHours // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RoomUsageReportImpl implements _RoomUsageReport {
  const _$RoomUsageReportImpl({
    @JsonKey(name: 'room_name') required this.roomName,
    @JsonKey(name: 'total_sessions') required this.sessions,
    @JsonKey(name: 'total_hours') required this.totalHours,
  });

  factory _$RoomUsageReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomUsageReportImplFromJson(json);

  @override
  @JsonKey(name: 'room_name')
  final String roomName;
  @override
  @JsonKey(name: 'total_sessions')
  final int sessions;
  @override
  @JsonKey(name: 'total_hours')
  final double totalHours;

  @override
  String toString() {
    return 'RoomUsageReport(roomName: $roomName, sessions: $sessions, totalHours: $totalHours)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomUsageReportImpl &&
            (identical(other.roomName, roomName) ||
                other.roomName == roomName) &&
            (identical(other.sessions, sessions) ||
                other.sessions == sessions) &&
            (identical(other.totalHours, totalHours) ||
                other.totalHours == totalHours));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, roomName, sessions, totalHours);

  /// Create a copy of RoomUsageReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomUsageReportImplCopyWith<_$RoomUsageReportImpl> get copyWith =>
      __$$RoomUsageReportImplCopyWithImpl<_$RoomUsageReportImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomUsageReportImplToJson(this);
  }
}

abstract class _RoomUsageReport implements RoomUsageReport {
  const factory _RoomUsageReport({
    @JsonKey(name: 'room_name') required final String roomName,
    @JsonKey(name: 'total_sessions') required final int sessions,
    @JsonKey(name: 'total_hours') required final double totalHours,
  }) = _$RoomUsageReportImpl;

  factory _RoomUsageReport.fromJson(Map<String, dynamic> json) =
      _$RoomUsageReportImpl.fromJson;

  @override
  @JsonKey(name: 'room_name')
  String get roomName;
  @override
  @JsonKey(name: 'total_sessions')
  int get sessions;
  @override
  @JsonKey(name: 'total_hours')
  double get totalHours;

  /// Create a copy of RoomUsageReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomUsageReportImplCopyWith<_$RoomUsageReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
