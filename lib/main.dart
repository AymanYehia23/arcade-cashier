import 'package:arcade_cashier/src/constants/app_env.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:arcade_cashier/src/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:arcade_cashier/src/features/settings/data/locale_repository.dart';
import 'package:arcade_cashier/src/core/logging_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load the appropriate env file based on the backend toggle.
  // Both files are gitignored — no secrets ever live in source code.
  final envFile = AppEnv.useTestBackend ? '.env.test' : '.env';
  bool envLoaded = false;
  try {
    await dotenv.load(fileName: envFile);
    envLoaded = true;
  } catch (e) {
    debugPrint("Note: $envFile not found (normal for CI/CD builds)");
  }

  usePathUrlStrategy();
  if (!kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.linux ||
          defaultTargetPlatform == TargetPlatform.macOS)) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      size: Size(1280, 720), // Default start size
      minimumSize: Size(1024, 768), // Minimum usable size
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
      title: 'Arcade Cashier',
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  final http.Client? httpClient = kDebugMode ? LoggingClient() : null;
  final sharedPrefs = await SharedPreferences.getInstance();

  // Credential priority:
  //   1. AppEnv (--dart-define for CI/CD, or useTestBackend flag)
  //   2. dotenv values from envFile — only accessed if load() succeeded
  String resolvedUrl = AppEnv.supabaseUrl;
  String resolvedKey = AppEnv.supabaseAnonKey;
  if (resolvedUrl.isEmpty && envLoaded) {
    resolvedUrl = dotenv.env['SUPABASE_URL'] ?? '';
    resolvedKey = dotenv.env['SUPABASE_ANON_KEY'] ?? '';
  }

  await Supabase.initialize(
    url: resolvedUrl,
    anonKey: resolvedKey,
    httpClient: httpClient,
  );

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(sharedPrefs)],
      child: const MyApp(),
    ),
  );
}
