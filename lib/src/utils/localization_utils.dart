import 'package:flutter/material.dart';

/// Extension to get localized text based on current locale
extension LocalizedText on BuildContext {
  /// Returns the appropriate text based on the current locale
  /// If the localized text is null or empty, falls back to the other language
  String getLocalizedText({
    required String? textEn,
    required String? textAr,
  }) {
    final locale = Localizations.localeOf(this);
    final isArabic = locale.languageCode == 'ar';

    if (isArabic) {
      // Prefer Arabic, fallback to English
      return textAr?.isNotEmpty == true ? textAr! : (textEn ?? '');
    } else {
      // Prefer English, fallback to Arabic
      return textEn?.isNotEmpty == true ? textEn! : (textAr ?? '');
    }
  }
}

/// Utility class to get localized text without context
class LocalizationUtils {
  /// Returns the appropriate text based on the provided language code
  static String getLocalizedText({
    required String? textEn,
    required String? textAr,
    required String languageCode,
  }) {
    final isArabic = languageCode == 'ar';

    if (isArabic) {
      // Prefer Arabic, fallback to English
      return textAr?.isNotEmpty == true ? textAr! : (textEn ?? '');
    } else {
      // Prefer English, fallback to Arabic
      return textEn?.isNotEmpty == true ? textEn! : (textAr ?? '');
    }
  }
}
