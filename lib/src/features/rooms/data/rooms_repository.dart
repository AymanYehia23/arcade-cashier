import 'package:arcade_cashier/src/core/supabase_provider.dart';
import 'package:arcade_cashier/src/features/rooms/domain/room.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'rooms_repository.g.dart';

class RoomsRepository {
  final SupabaseClient _supabase;

  RoomsRepository(this._supabase);

  Stream<List<Room>> watchRooms() {
    return _supabase
        .from('rooms')
        .stream(primaryKey: ['id'])
        .map((data) => data.map((json) => Room.fromJson(json)).toList());
  }

  Future<void> updateRoomStatus(int roomId, RoomStatus status) async {
    await _supabase.from('rooms').update({'current_status': status.name}).match(
      {'id': roomId},
    );
  }
}

@Riverpod(keepAlive: true)
RoomsRepository roomsRepository(Ref ref) {
  return RoomsRepository(ref.watch(supabaseProvider));
}

@riverpod
Stream<List<Room>> roomsValues(Ref ref) {
  final repository = ref.watch(roomsRepositoryProvider);
  return repository.watchRooms();
}
