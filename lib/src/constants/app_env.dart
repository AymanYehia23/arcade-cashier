/// Environment configuration for Supabase backend switching.
///
/// Credential resolution priority:
/// 1. --dart-define (CI/CD) — always wins; guarantees production in GitHub Actions.
/// 2. [useTestBackend] == true → .env.test file (gitignored, loaded in main.dart).
/// 3. .env file (gitignored, loaded in main.dart) → production for local debug.
///
/// ⚠️  No secrets of any kind are stored in this file.
///    Test credentials → gitignored `.env.test`
///    Prod credentials → gitignored `.env` / GitHub Actions secrets
class AppEnv {
  AppEnv._();

  /// 🔴 Set to `true` for Test backend, `false` for Production.
  static const bool useTestBackend = false;

  // ---------------------------------------------------------------------------
  // Test credentials — loaded from gitignored `.env.test` in main.dart.
  // These constants are intentionally empty; DO NOT hardcode secrets here.
  // ---------------------------------------------------------------------------
  static const String _testUrl = '';
  static const String _testAnonKey = '';

  // ---------------------------------------------------------------------------
  // Production credentials (fallback for local debug when useTestBackend = false)
  // ---------------------------------------------------------------------------
  // Keep these in sync with your actual production Supabase project.
  static const String _prodUrl = String.fromEnvironment('SUPABASE_URL');
  static const String _prodAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
  );

  // Prod fallback is intentionally empty — credentials must come from the
  // gitignored `.env` file (loaded in main.dart via flutter_dotenv).
  // DO NOT hardcode production secrets here.
  static const String _prodUrlFallback = '';
  static const String _prodAnonKeyFallback = '';

  // ---------------------------------------------------------------------------
  // Public getters — use these everywhere in the app.
  // ---------------------------------------------------------------------------

  /// Resolved Supabase URL following the priority chain:
  /// 1. --dart-define SUPABASE_URL    (CI/CD — always production)
  /// 2. useTestBackend == true         (local dev toggle)
  /// 3. Hardcoded prod fallback        (local debug, useTestBackend = false)
  static String get supabaseUrl {
    if (_prodUrl.isNotEmpty) return _prodUrl; // CI/CD always wins
    if (useTestBackend) return _testUrl;
    return _prodUrlFallback;
  }

  /// Resolved Supabase Anon Key following the same priority chain.
  static String get supabaseAnonKey {
    if (_prodAnonKey.isNotEmpty) return _prodAnonKey; // CI/CD always wins
    if (useTestBackend) return _testAnonKey;
    return _prodAnonKeyFallback;
  }
}
