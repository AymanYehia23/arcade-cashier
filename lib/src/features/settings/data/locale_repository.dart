import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'locale_repository.g.dart';

class LocaleRepository {
  final SharedPreferences _sharedPreferences;
  static const _kLocaleKey = 'locale';

  LocaleRepository(this._sharedPreferences);

  Future<void> saveLocale(Locale locale) async {
    await _sharedPreferences.setString(_kLocaleKey, locale.languageCode);
  }

  Locale? getSavedLocale() {
    final languageCode = _sharedPreferences.getString(_kLocaleKey);
    if (languageCode == null) return null;
    return Locale(languageCode);
  }
}

@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError();
}

@Riverpod(keepAlive: true)
LocaleRepository localeRepository(Ref ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return LocaleRepository(sharedPreferences);
}
