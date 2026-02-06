import 'package:arcade_cashier/src/features/rooms/data/rooms_repository.dart';
import 'package:arcade_cashier/src/features/rooms/domain/room.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rooms_controller.g.dart';

@riverpod
class RoomsController extends _$RoomsController {
  @override
  FutureOr<void> build() {
    // nothing to initialize
  }

  Future<void> updateRoomStatus(int roomId, RoomStatus newStatus) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () =>
          ref.read(roomsRepositoryProvider).updateRoomStatus(roomId, newStatus),
    );
  }
}
