import 'package:arcade_cashier/src/features/sessions/data/sessions_repository.dart';
import 'package:arcade_cashier/src/features/sessions/domain/match_type.dart';
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
    required MatchType matchType,
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
            matchType: matchType,
            sessionType: sessionType,
            plannedDurationMinutes: plannedDurationMinutes,
          );
      // Stream + DB trigger handle UI update automatically
      state = const AsyncData(null);
      return session;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
  }

  Future<Session?> startTableSession({required int tableId}) async {
    state = const AsyncLoading();
    try {
      final session = await ref
          .read(sessionsRepositoryProvider)
          .startTableSession(tableId: tableId);
      // Stream + DB trigger handle UI update automatically
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

  Future<void> stopSession({required int sessionId}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(sessionsRepositoryProvider)
          .stopSession(sessionId: sessionId);
      // Stream + DB trigger handle UI update automatically
    });
  }

  Future<void> pauseSession(int sessionId, int? roomId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(sessionsRepositoryProvider).pauseSession(sessionId);
      // Stream handles UI update automatically
    });
  }

  Future<void> resumeSession(int sessionId, int? roomId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(sessionsRepositoryProvider).resumeSession(sessionId);
      // Stream handles UI update automatically
    });
  }

  Future<int?> checkoutSession({
    required int sessionId,
    required double totalAmount,
    required double discountAmount,
    required double discountPercentage,
    required String paymentMethod,
    int? customerId,
    String? customerName,
    String shopName = 'Arcade',
    int? shiftId,
    String? sourceName,
  }) async {
    state = const AsyncLoading();
    try {
      final invoiceId = await ref
          .read(sessionsRepositoryProvider)
          .checkoutSession(
            sessionId: sessionId,
            totalAmount: totalAmount,
            discountAmount: discountAmount,
            discountPercentage: discountPercentage,
            paymentMethod: paymentMethod,
            customerId: customerId,
            customerName: customerName,
            shopName: shopName,
            shiftId: shiftId,
            sourceName: sourceName,
          );
      state = const AsyncData(null);
      return invoiceId;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
  }
}

@riverpod
Future<Session?> activeSession(Ref ref, int roomId) {
  return ref.read(sessionsRepositoryProvider).getActiveSession(roomId);
}

@riverpod
Future<Session?> activeTableSession(Ref ref, int tableId) {
  return ref.read(sessionsRepositoryProvider).getActiveTableSession(tableId);
}

@riverpod
Future<Session?> sessionById(Ref ref, int sessionId) {
  return ref.read(sessionsRepositoryProvider).getSessionById(sessionId);
}

@riverpod
Stream<List<Session>> activeSessions(Ref ref) {
  return ref.watch(sessionsRepositoryProvider).watchActiveSessions();
}
