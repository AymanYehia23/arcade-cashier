import 'package:arcade_cashier/src/core/supabase_provider.dart';
import 'package:arcade_cashier/src/features/authentication/domain/app_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

part 'auth_repository.g.dart';

class AuthRepository {
  final supabase.SupabaseClient _supabase;
  AppUser? _cachedUser;

  AuthRepository(this._supabase);

  Stream<AppUser?> authStateChanges() async* {
    await for (final event in _supabase.auth.onAuthStateChange) {
      final user = event.session?.user;
      if (user == null) {
        yield null;
        continue;
      }

      // If we have a cached user that matches the current session user, yield it immediately
      if (_cachedUser != null && _cachedUser!.uid == user.id) {
        yield _cachedUser;
      }

      try {
        // Fetch user data from app_users table
        // Note: Table uses 'id' instead of 'uid', and email is best taken from auth user
        final userData = await _supabase
            .from('app_users')
            .select('role')
            .eq('id', user.id)
            .maybeSingle();

        if (userData != null) {
          _cachedUser = AppUser(
            uid: user.id,
            email: user.email ?? '',
            role: userData['role'] as String? ?? 'customer',
          );
        } else {
          // Fallback: create user with default role if not found in table
          _cachedUser = AppUser(
            uid: user.id,
            email: user.email ?? '',
            role: 'customer',
          );
        }
        yield _cachedUser;
      } catch (e) {
        // Fallback on error
        _cachedUser = AppUser(
          uid: user.id,
          email: user.email ?? '',
          role: 'customer',
        );
        yield _cachedUser;
      }
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    _cachedUser = null;
    await _supabase.auth.signOut();
  }

  Future<AppUser?> getCurrentUser() async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      _cachedUser = null;
      return null;
    }

    // Return cached user if it matches current session
    if (_cachedUser != null && _cachedUser!.uid == user.id) {
      return _cachedUser;
    }

    try {
      // Fetch user data from app_users table
      final userData = await _supabase
          .from('app_users')
          .select('role')
          .eq('id', user.id) // Query by 'id'
          .maybeSingle();

      if (userData != null) {
        _cachedUser = AppUser(
          uid: user.id,
          email: user.email ?? '',
          role: userData['role'] as String? ?? 'customer',
        );
      } else {
        // Fallback: create user with default role if not found in table
        _cachedUser = AppUser(
          uid: user.id,
          email: user.email ?? '',
          role: 'customer',
        );
      }
      return _cachedUser;
    } catch (e) {
      // Fallback on error
      return AppUser(uid: user.id, email: user.email ?? '', role: 'customer');
    }
  }

  // Synchronous check for basic authentication status
  bool get isAuthenticated => _supabase.auth.currentUser != null;
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepository(ref.watch(supabaseProvider));
}

@Riverpod(keepAlive: true)
Stream<AppUser?> authStateChanges(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
}
