import 'package:arcade_cashier/src/features/rooms/data/rooms_repository.dart';
import 'package:arcade_cashier/src/features/sessions/data/sessions_repository.dart';
import 'package:arcade_cashier/src/features/sessions/domain/session.dart';
import 'package:arcade_cashier/src/features/sessions/domain/session_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sessions_controller.g.dart';

@Riverpod(keepAlive: true)
class SessionsController extends _$SessionsController {
  @override
  FutureOr<void> build() {
    // initial state
  }

  Future<Session?> startSession({
    int? roomId,
    required double rate,
    required bool isMultiMatch,
    required SessionType sessionType,
    int? plannedDurationMinutes,
  }) async {
    state = const AsyncLoading();
    try {
      final session = await ref
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
      state = const AsyncData(null);
      return session;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
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
    });
  }

  Future<void> stopSession({required int sessionId, int? roomId}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(sessionsRepositoryProvider)
          .stopSession(sessionId: sessionId, roomId: roomId);
      // Invalidate rooms to refresh UI
      ref.invalidate(roomsValuesProvider);
    });
  }

  Future<void> pauseSession(int sessionId, int? roomId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(sessionsRepositoryProvider).pauseSession(sessionId);
      ref.invalidate(sessionByIdProvider(sessionId));
      if (roomId != null) {
        ref.invalidate(activeSessionProvider(roomId));
      }
    });
  }

  Future<void> resumeSession(int sessionId, int? roomId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(sessionsRepositoryProvider).resumeSession(sessionId);
      ref.invalidate(sessionByIdProvider(sessionId));
      if (roomId != null) {
        ref.invalidate(activeSessionProvider(roomId));
      }
    });
  }
}

@riverpod
Future<Session?> activeSession(Ref ref, int roomId) {
  return ref.read(sessionsRepositoryProvider).getActiveSession(roomId);
}

@riverpod
Future<Session?> sessionById(Ref ref, int sessionId) {
  return ref.read(sessionsRepositoryProvider).getSessionById(sessionId);
}
