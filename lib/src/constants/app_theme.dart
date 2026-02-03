import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Color Palette
  static const Color _background = Color(0xFF121212); // Very Dark Blue/Grey
  static const Color _surface = Color(0xFF2E2E40); // Slightly lighter dark grey
  static const Color _primaryAccent = Color(0xFF0070D1); // PlayStation Blue
  static const Color _secondaryAccent = Color(0xFF39FF14); // Neon Green
  static const Color _error = Color(0xFFFF0033); // Bright Red
  static const Color _textWhite = Colors.white;
  static const Color _textGrey = Color(0xFFB0B0C0);

  static ThemeData getDarkTheme(Locale locale) {
    final isArabic = locale.languageCode == 'ar';
    final fontFamily = isArabic ? 'Cairo' : GoogleFonts.roboto().fontFamily;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: _primaryAccent,
      scaffoldBackgroundColor: _background,
      colorScheme: const ColorScheme.dark(
        primary: _primaryAccent,
        secondary: _secondaryAccent,
        surface: _surface,
        error: _error,
        onPrimary: _textWhite,
        onSecondary: _background,
        onSurface: _textWhite,
        onError: _textWhite,
      ),

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: _background,
        foregroundColor: _textWhite,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: _textWhite,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: _surface,
        elevation: 4,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryAccent,
          foregroundColor: _textWhite,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _textWhite,
          side: const BorderSide(color: _primaryAccent, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _primaryAccent, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _error, width: 1),
        ),
        hintStyle: const TextStyle(color: _textGrey),
        labelStyle: const TextStyle(color: _textWhite),
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: _background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        titleTextStyle: const TextStyle(
          color: _textWhite,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        contentTextStyle: const TextStyle(color: _textGrey, fontSize: 16),
      ),

      // Text Theme
      fontFamily: fontFamily,
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: _textWhite,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: _textWhite,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(
          color: _textWhite,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(color: _textWhite, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(color: _textWhite, fontWeight: FontWeight.w600),
        titleSmall: TextStyle(color: _textWhite, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: _textGrey),
        bodyMedium: TextStyle(color: _textGrey),
        bodySmall: TextStyle(color: _textGrey),
      ),
    );
  }
}
