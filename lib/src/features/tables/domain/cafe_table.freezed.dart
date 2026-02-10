// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cafe_table.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CafeTable _$CafeTableFromJson(Map<String, dynamic> json) {
  return _CafeTable.fromJson(json);
}

/// @nodoc
mixin _$CafeTable {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'table_number')
  int? get tableNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_status')
  TableStatus get currentStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this CafeTable to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CafeTable
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CafeTableCopyWith<CafeTable> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CafeTableCopyWith<$Res> {
  factory $CafeTableCopyWith(CafeTable value, $Res Function(CafeTable) then) =
      _$CafeTableCopyWithImpl<$Res, CafeTable>;
  @useResult
  $Res call({
    int id,
    String name,
    @JsonKey(name: 'table_number') int? tableNumber,
    @JsonKey(name: 'current_status') TableStatus currentStatus,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class _$CafeTableCopyWithImpl<$Res, $Val extends CafeTable>
    implements $CafeTableCopyWith<$Res> {
  _$CafeTableCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CafeTable
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? tableNumber = freezed,
    Object? currentStatus = null,
    Object? createdAt = null,
    Object? updatedAt = null,
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
            tableNumber: freezed == tableNumber
                ? _value.tableNumber
                : tableNumber // ignore: cast_nullable_to_non_nullable
                      as int?,
            currentStatus: null == currentStatus
                ? _value.currentStatus
                : currentStatus // ignore: cast_nullable_to_non_nullable
                      as TableStatus,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CafeTableImplCopyWith<$Res>
    implements $CafeTableCopyWith<$Res> {
  factory _$$CafeTableImplCopyWith(
    _$CafeTableImpl value,
    $Res Function(_$CafeTableImpl) then,
  ) = __$$CafeTableImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    @JsonKey(name: 'table_number') int? tableNumber,
    @JsonKey(name: 'current_status') TableStatus currentStatus,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class __$$CafeTableImplCopyWithImpl<$Res>
    extends _$CafeTableCopyWithImpl<$Res, _$CafeTableImpl>
    implements _$$CafeTableImplCopyWith<$Res> {
  __$$CafeTableImplCopyWithImpl(
    _$CafeTableImpl _value,
    $Res Function(_$CafeTableImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CafeTable
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? tableNumber = freezed,
    Object? currentStatus = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$CafeTableImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        tableNumber: freezed == tableNumber
            ? _value.tableNumber
            : tableNumber // ignore: cast_nullable_to_non_nullable
                  as int?,
        currentStatus: null == currentStatus
            ? _value.currentStatus
            : currentStatus // ignore: cast_nullable_to_non_nullable
                  as TableStatus,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CafeTableImpl implements _CafeTable {
  const _$CafeTableImpl({
    required this.id,
    required this.name,
    @JsonKey(name: 'table_number') this.tableNumber,
    @JsonKey(name: 'current_status') required this.currentStatus,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') required this.updatedAt,
  });

  factory _$CafeTableImpl.fromJson(Map<String, dynamic> json) =>
      _$$CafeTableImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  @JsonKey(name: 'table_number')
  final int? tableNumber;
  @override
  @JsonKey(name: 'current_status')
  final TableStatus currentStatus;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @override
  String toString() {
    return 'CafeTable(id: $id, name: $name, tableNumber: $tableNumber, currentStatus: $currentStatus, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CafeTableImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.tableNumber, tableNumber) ||
                other.tableNumber == tableNumber) &&
            (identical(other.currentStatus, currentStatus) ||
                other.currentStatus == currentStatus) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    tableNumber,
    currentStatus,
    createdAt,
    updatedAt,
  );

  /// Create a copy of CafeTable
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CafeTableImplCopyWith<_$CafeTableImpl> get copyWith =>
      __$$CafeTableImplCopyWithImpl<_$CafeTableImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CafeTableImplToJson(this);
  }
}

abstract class _CafeTable implements CafeTable {
  const factory _CafeTable({
    required final int id,
    required final String name,
    @JsonKey(name: 'table_number') final int? tableNumber,
    @JsonKey(name: 'current_status') required final TableStatus currentStatus,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'updated_at') required final DateTime updatedAt,
  }) = _$CafeTableImpl;

  factory _CafeTable.fromJson(Map<String, dynamic> json) =
      _$CafeTableImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'table_number')
  int? get tableNumber;
  @override
  @JsonKey(name: 'current_status')
  TableStatus get currentStatus;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;

  /// Create a copy of CafeTable
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CafeTableImplCopyWith<_$CafeTableImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
