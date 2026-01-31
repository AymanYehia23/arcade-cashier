// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'room.freezed.dart';
part 'room.g.dart';

enum RoomStatus { available, occupied, maintenance, held }

@freezed
class Room with _$Room {
  const factory Room({
    required int id,
    required String name,
    @JsonKey(name: 'device_type') required String deviceType,
    @JsonKey(name: 'hourly_rate') required double hourlyRate,
    @JsonKey(name: 'current_status') required RoomStatus currentStatus,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}
