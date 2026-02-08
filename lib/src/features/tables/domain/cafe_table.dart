// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cafe_table.freezed.dart';
part 'cafe_table.g.dart';

enum TableStatus { available, occupied, maintenance }

@freezed
class CafeTable with _$CafeTable {
  const factory CafeTable({
    required int id,
    required String name,
    @JsonKey(name: 'table_number') int? tableNumber,
    @JsonKey(name: 'current_status') required TableStatus currentStatus,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _CafeTable;

  factory CafeTable.fromJson(Map<String, dynamic> json) =>
      _$CafeTableFromJson(json);
}
