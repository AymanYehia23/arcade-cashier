// ignore_for_file: invalid_annotation_target
import 'package:arcade_cashier/src/features/rooms/domain/device_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'room.freezed.dart';
part 'room.g.dart';

enum RoomStatus { available, occupied, maintenance, held }

@freezed
class Room with _$Room {
  const factory Room({
    required int id,
    required String name,
    @JsonKey(name: 'device_type') required DeviceType deviceType,
    @JsonKey(name: 'hourly_rate') required double singleMatchHourlyRate,
    @JsonKey(name: 'multi_player_hourly_rate')
    required double multiMatchHourlyRate,
    @JsonKey(name: 'other_hourly_rate') required double otherHourlyRate,
    @JsonKey(name: 'current_status') required RoomStatus currentStatus,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}
