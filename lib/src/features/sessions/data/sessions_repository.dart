import 'package:arcade_cashier/src/constants/db_constants.dart';
import 'package:arcade_cashier/src/core/supabase_provider.dart';

import 'package:arcade_cashier/src/features/sessions/domain/session.dart'
    as domain;
import 'package:arcade_cashier/src/features/sessions/domain/session_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'sessions_repository.g.dart';

abstract class SessionsRepository {
  Future<domain.Session> startSession({
    int? roomId,
    required double rate,
    required bool isMultiMatch,
    required SessionType sessionType,
    int? plannedDurationMinutes,
  });
  Future<void> stopSession({required int sessionId, int? roomId});
  Future<void> pauseSession(int sessionId);
  Future<void> resumeSession(int sessionId);
  Future<void> extendSession({
    required int sessionId,
    required int additionalMinutes,
  });
  Future<domain.Session?> getActiveSession(int roomId);
  Stream<List<domain.Session>> watchActiveSessions();
  Future<domain.Session?> getSessionById(int sessionId);
}

class SupabaseSessionsRepository implements SessionsRepository {
  final SupabaseClient _supabase;

  SupabaseSessionsRepository(this._supabase);

  @override
  Future<domain.Session> startSession({
    int? roomId,
    required double rate,
    required bool isMultiMatch,
    required SessionType sessionType,
    int? plannedDurationMinutes,
  }) async {
    // 1. Insert session
    final sessionData = await _supabase
        .from(DbTables.sessions)
        .insert({
          'room_id': roomId,
          'start_time': DateTime.now().toUtc().toIso8601String(),
          'applied_hourly_rate': rate,
          'is_multi_match': isMultiMatch,
          // Force 'open' if room_id is null (Quick Order), otherwise use provided type
          'session_type': roomId == null
              ? SessionConstants.open
              : sessionType.name,
          'planned_duration_minutes': plannedDurationMinutes,
          'status': SessionConstants.active,
        })
        .select()
        .single();

    // 2. Update room status (ONLY if room assigned)
    if (roomId != null) {
      await _supabase
          .from(DbTables.rooms)
          .update({'current_status': RoomConstants.occupied})
          .match({'id': roomId});
    }

    return domain.Session.fromJson(sessionData);
  }

  @override
  Future<void> extendSession({
    required int sessionId,
    required int additionalMinutes,
  }) async {
    // We need to fetch current planned duration first strictly speaking, OR allow SQL increment?
    // Supabase supports RPC for increment, but simple update is easier if we trust client state.
    // However, for robustness, fetching first or using rpc is better.
    // Let's assume we can use a simple rpc or just fetch-update for now to avoid creating SQL functions if not allowed to create migrations easily.

    // Fetch current session
    final session = await _supabase
        .from(DbTables.sessions)
        .select('planned_duration_minutes')
        .eq('id', sessionId)
        .single();

    final currentDuration = session['planned_duration_minutes'] as int? ?? 0;

    await _supabase
        .from(DbTables.sessions)
        .update({
          'planned_duration_minutes': currentDuration + additionalMinutes,
        })
        .match({'id': sessionId});
  }

  @override
  Future<void> pauseSession(int sessionId) async {
    await _supabase
        .from(DbTables.sessions)
        .update({
          'status': SessionConstants.paused,
          'paused_at': DateTime.now().toUtc().toIso8601String(),
        })
        .match({'id': sessionId});
  }

  @override
  Future<void> resumeSession(int sessionId) async {
    // 1. Fetch current session to get paused_at and total_paused_duration_seconds
    final sessionData = await _supabase
        .from(DbTables.sessions)
        .select('paused_at, total_paused_duration_seconds')
        .eq('id', sessionId)
        .single();

    final pausedAtIso = sessionData['paused_at'] as String?;
    final currentTotalPaused =
        sessionData['total_paused_duration_seconds'] as int? ?? 0;

    int additionalPausedSeconds = 0;
    if (pausedAtIso != null) {
      final pausedAt = DateTime.parse(pausedAtIso);
      additionalPausedSeconds = DateTime.now()
          .toUtc()
          .difference(pausedAt)
          .inSeconds;
    }

    await _supabase
        .from(DbTables.sessions)
        .update({
          'status': SessionConstants.active,
          'paused_at': null,
          'total_paused_duration_seconds':
              currentTotalPaused + additionalPausedSeconds,
        })
        .match({'id': sessionId});
  }

  @override
  Future<void> stopSession({required int sessionId, int? roomId}) async {
    // 1. Update session
    await _supabase
        .from(DbTables.sessions)
        .update({
          'end_time': DateTime.now().toUtc().toIso8601String(),
          'status': SessionConstants.completed,
        })
        .match({'id': sessionId});

    // 2. Update room status (ONLY if room assigned)
    if (roomId != null) {
      await _supabase
          .from(DbTables.rooms)
          .update({'current_status': RoomConstants.available})
          .match({'id': roomId});
    }
  }

  @override
  Future<domain.Session?> getActiveSession(int roomId) async {
    try {
      final sessionData = await _supabase
          .from(DbTables.sessions)
          .select()
          .eq('room_id', roomId)
          .filter('end_time', 'is', null) // Use filter for IS NULL
          .maybeSingle(); // Use maybeSingle to return null if no row found

      if (sessionData == null) {
        return null;
      }
      return domain.Session.fromJson(sessionData);
    } catch (e) {
      // Log the error for debugging but return null as defensive programming
      return null;
    }
  }

  @override
  Future<domain.Session?> getSessionById(int sessionId) async {
    try {
      final sessionData = await _supabase
          .from(DbTables.sessions)
          .select()
          .eq('id', sessionId)
          .maybeSingle();

      if (sessionData == null) return null;
      return domain.Session.fromJson(sessionData);
    } catch (e) {
      return null;
    }
  }

  @override
  Stream<List<domain.Session>> watchActiveSessions() {
    return _supabase
        .from(DbTables.sessions)
        .stream(primaryKey: ['id'])
        .order('start_time')
        .map(
          (data) => data
              .where((element) => element['end_time'] == null)
              .map((e) => domain.Session.fromJson(e))
              .toList(),
        );
  }
}

@Riverpod(keepAlive: true)
SessionsRepository sessionsRepository(Ref ref) {
  return SupabaseSessionsRepository(ref.watch(supabaseProvider));
}
