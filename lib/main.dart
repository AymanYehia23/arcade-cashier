import 'package:arcade_cashier/src/constants/app_constants.dart';
import 'package:arcade_cashier/src/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:arcade_cashier/src/core/logging_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final http.Client? httpClient = kDebugMode ? LoggingClient() : null;

  await Supabase.initialize(
    url: AppConstants.supabaseUrl,
    anonKey: AppConstants.supabaseAnonKey,
    httpClient: httpClient,
  );

  runApp(const ProviderScope(child: MyApp()));
}
