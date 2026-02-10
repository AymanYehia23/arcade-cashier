// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'table_with_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TableWithSession {
  CafeTable get table => throw _privateConstructorUsedError;
  Session? get activeSession => throw _privateConstructorUsedError;

  /// Create a copy of TableWithSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TableWithSessionCopyWith<TableWithSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TableWithSessionCopyWith<$Res> {
  factory $TableWithSessionCopyWith(
    TableWithSession value,
    $Res Function(TableWithSession) then,
  ) = _$TableWithSessionCopyWithImpl<$Res, TableWithSession>;
  @useResult
  $Res call({CafeTable table, Session? activeSession});

  $CafeTableCopyWith<$Res> get table;
  $SessionCopyWith<$Res>? get activeSession;
}

/// @nodoc
class _$TableWithSessionCopyWithImpl<$Res, $Val extends TableWithSession>
    implements $TableWithSessionCopyWith<$Res> {
  _$TableWithSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TableWithSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? table = null, Object? activeSession = freezed}) {
    return _then(
      _value.copyWith(
            table: null == table
                ? _value.table
                : table // ignore: cast_nullable_to_non_nullable
                      as CafeTable,
            activeSession: freezed == activeSession
                ? _value.activeSession
                : activeSession // ignore: cast_nullable_to_non_nullable
                      as Session?,
          )
          as $Val,
    );
  }

  /// Create a copy of TableWithSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CafeTableCopyWith<$Res> get table {
    return $CafeTableCopyWith<$Res>(_value.table, (value) {
      return _then(_value.copyWith(table: value) as $Val);
    });
  }

  /// Create a copy of TableWithSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SessionCopyWith<$Res>? get activeSession {
    if (_value.activeSession == null) {
      return null;
    }

    return $SessionCopyWith<$Res>(_value.activeSession!, (value) {
      return _then(_value.copyWith(activeSession: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TableWithSessionImplCopyWith<$Res>
    implements $TableWithSessionCopyWith<$Res> {
  factory _$$TableWithSessionImplCopyWith(
    _$TableWithSessionImpl value,
    $Res Function(_$TableWithSessionImpl) then,
  ) = __$$TableWithSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({CafeTable table, Session? activeSession});

  @override
  $CafeTableCopyWith<$Res> get table;
  @override
  $SessionCopyWith<$Res>? get activeSession;
}

/// @nodoc
class __$$TableWithSessionImplCopyWithImpl<$Res>
    extends _$TableWithSessionCopyWithImpl<$Res, _$TableWithSessionImpl>
    implements _$$TableWithSessionImplCopyWith<$Res> {
  __$$TableWithSessionImplCopyWithImpl(
    _$TableWithSessionImpl _value,
    $Res Function(_$TableWithSessionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TableWithSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? table = null, Object? activeSession = freezed}) {
    return _then(
      _$TableWithSessionImpl(
        table: null == table
            ? _value.table
            : table // ignore: cast_nullable_to_non_nullable
                  as CafeTable,
        activeSession: freezed == activeSession
            ? _value.activeSession
            : activeSession // ignore: cast_nullable_to_non_nullable
                  as Session?,
      ),
    );
  }
}

/// @nodoc

class _$TableWithSessionImpl implements _TableWithSession {
  const _$TableWithSessionImpl({required this.table, this.activeSession});

  @override
  final CafeTable table;
  @override
  final Session? activeSession;

  @override
  String toString() {
    return 'TableWithSession(table: $table, activeSession: $activeSession)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TableWithSessionImpl &&
            (identical(other.table, table) || other.table == table) &&
            (identical(other.activeSession, activeSession) ||
                other.activeSession == activeSession));
  }

  @override
  int get hashCode => Object.hash(runtimeType, table, activeSession);

  /// Create a copy of TableWithSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TableWithSessionImplCopyWith<_$TableWithSessionImpl> get copyWith =>
      __$$TableWithSessionImplCopyWithImpl<_$TableWithSessionImpl>(
        this,
        _$identity,
      );
}

abstract class _TableWithSession implements TableWithSession {
  const factory _TableWithSession({
    required final CafeTable table,
    final Session? activeSession,
  }) = _$TableWithSessionImpl;

  @override
  CafeTable get table;
  @override
  Session? get activeSession;

  /// Create a copy of TableWithSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TableWithSessionImplCopyWith<_$TableWithSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
