import 'package:arcade_cashier/src/features/rooms/data/rooms_repository.dart';
import 'package:arcade_cashier/src/features/rooms/domain/device_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'room_form_controller.g.dart';

@riverpod
class RoomFormController extends _$RoomFormController {
  @override
  FutureOr<void> build() {
    // nothing to initialize
  }

  Future<bool> createRoom({
    required String name,
    required DeviceType deviceType,
    required double singleMatchHourlyRate,
    required double multiMatchHourlyRate,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(roomsRepositoryProvider)
          .createRoom(
            name: name,
            deviceType: deviceType,
            singleMatchHourlyRate: singleMatchHourlyRate,
            multiMatchHourlyRate: multiMatchHourlyRate,
          ),
    );
    if (!state.hasError) {
      ref.invalidate(roomsValuesProvider);
    }
    return !state.hasError;
  }

  Future<bool> updateRoom({
    required int roomId,
    required String name,
    required DeviceType deviceType,
    required double singleMatchHourlyRate,
    required double multiMatchHourlyRate,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(roomsRepositoryProvider)
          .updateRoomDetails(
            roomId: roomId,
            name: name,
            deviceType: deviceType,
            singleMatchHourlyRate: singleMatchHourlyRate,
            multiMatchHourlyRate: multiMatchHourlyRate,
          ),
    );
    if (!state.hasError) {
      ref.invalidate(roomsValuesProvider);
    }
    return !state.hasError;
  }

  Future<bool> deleteRoom(int roomId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(roomsRepositoryProvider).deleteRoom(roomId),
    );
    if (!state.hasError) {
      ref.invalidate(roomsValuesProvider);
    }
    return !state.hasError;
  }
}
