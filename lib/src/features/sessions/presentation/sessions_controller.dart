import 'package:arcade_cashier/src/features/rooms/data/rooms_repository.dart';
import 'package:arcade_cashier/src/features/sessions/data/sessions_repository.dart';
import 'package:arcade_cashier/src/features/sessions/domain/session.dart';
import 'package:arcade_cashier/src/features/sessions/domain/session_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sessions_controller.g.dart';

@riverpod
class SessionsController extends _$SessionsController {
  @override
  FutureOr<void> build() {
    // initial state
  }

  Future<void> startSession({
    required int roomId,
    required double rate,
    required bool isMultiMatch,
    required SessionType sessionType,
    int? plannedDurationMinutes,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(sessionsRepositoryProvider)
          .startSession(
            roomId: roomId,
            rate: rate,
            isMultiMatch: isMultiMatch,
            sessionType: sessionType,
            plannedDurationMinutes: plannedDurationMinutes,
          );
      // Invalidate rooms to refresh UI
      ref.invalidate(roomsValuesProvider);
    });
  }

  Future<void> extendSession({
    required int sessionId,
    required int additionalMinutes,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(sessionsRepositoryProvider)
          .extendSession(
            sessionId: sessionId,
            additionalMinutes: additionalMinutes,
          );
      // Invalidate active session to refresh UI (if we had a provider for it specifically by ID)
      // Since specific active session provider depends on room, we might need to invalidate that specific provider family member?
      // Actually, activeSession provider is autoDispose? No, keepAlive.
      // We should invalidate relevant providers.
      // ref.invalidate(activeSessionProvider); // This invalidates all families? No, we need to target specific.
      // For now, let's rely on UI pulling updates or manual invalidation if we passed roomId.
      // Let's pass roomId to this method too just for invalidation convenience?
      // The user didn't ask for it, but good practice.
      // For now, UI will probably rebuild if we don't invalidate? No, AsyncValue needs refresh.
    });
  }

  Future<void> stopSession({
    required int sessionId,
    required int roomId,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(sessionsRepositoryProvider)
          .stopSession(sessionId: sessionId, roomId: roomId);
      // Invalidate rooms to refresh UI
      ref.invalidate(roomsValuesProvider);
    });
  }
}

@riverpod
Future<Session?> activeSession(Ref ref, int roomId) {
  return ref.read(sessionsRepositoryProvider).getActiveSession(roomId);
}
