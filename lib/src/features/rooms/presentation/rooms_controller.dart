import 'package:arcade_cashier/src/features/rooms/data/rooms_repository.dart';
import 'package:arcade_cashier/src/features/rooms/domain/room.dart';
import 'package:arcade_cashier/src/features/sessions/data/sessions_repository.dart';
import 'package:arcade_cashier/src/features/sessions/domain/session.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';

part 'rooms_controller.g.dart';

/// A room paired with its active session (if any)
typedef RoomWithSession = ({Room room, Session? activeSession});

@riverpod
class RoomsController extends _$RoomsController {
  @override
  FutureOr<void> build() {
    // DB triggers now handle room status updates automatically
  }
}

@riverpod
Stream<List<RoomWithSession>> roomsWithSessions(Ref ref) {
  final roomsRepo = ref.watch(roomsRepositoryProvider);
  final sessionsRepo = ref.watch(sessionsRepositoryProvider);

  return Rx.combineLatest2<List<Room>, List<Session>, List<RoomWithSession>>(
    roomsRepo.watchRooms(),
    sessionsRepo.watchActiveSessions(),
    (rooms, sessions) {
      return rooms.map((room) {
        final activeSession = sessions.firstWhereOrNull(
          (s) => s.roomId == room.id,
        );
        return (room: room, activeSession: activeSession);
      }).toList();
    },
  );
}
