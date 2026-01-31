import 'package:flutter/material.dart';
import 'package:arcade_cashier/src/features/settings/data/locale_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locale_controller.g.dart';

@riverpod
class LocaleController extends _$LocaleController {
  @override
  Locale build() {
    // Load from repository synchronously (SharedPreferences is already initialized)
    final repository = ref.read(localeRepositoryProvider);
    return repository.getSavedLocale() ?? const Locale('en');
  }

  void setLocale(Locale locale) {
    if (state != locale) {
      state = locale;
      ref.read(localeRepositoryProvider).saveLocale(locale);
    }
  }

  void toggleLocale() {
    if (state.languageCode == 'en') {
      setLocale(const Locale('ar'));
    } else {
      setLocale(const Locale('en'));
    }
  }
}
