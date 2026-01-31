import 'package:arcade_cashier/src/constants/app_constants.dart';
import 'package:arcade_cashier/src/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:arcade_cashier/src/features/settings/data/locale_repository.dart';
import 'package:arcade_cashier/src/core/logging_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final http.Client? httpClient = kDebugMode ? LoggingClient() : null;
  final sharedPrefs = await SharedPreferences.getInstance();

  await Supabase.initialize(
    url: AppConstants.supabaseUrl,
    anonKey: AppConstants.supabaseAnonKey,
    httpClient: httpClient,
  );

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(sharedPrefs)],
      child: const MyApp(),
    ),
  );
}
