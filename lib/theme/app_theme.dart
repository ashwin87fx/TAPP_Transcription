import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Premium Dark Gray Palette
  static const Color primaryColor = Color(0xFFA855F7); // Vivid Purple
  static const Color accentColor = Color(0xFFD8B4FE); // Lavender
  static const Color backgroundColor = Color(0xFF1A1A1A); // Premium Dark Gray
  static const Color surfaceColor = Color(0xFF262626); // Lighter Gray Surface
  static const Color onBackground = Colors.white;

  // Rich Gradient: Deep Black -> Dark Purple -> Deep Black
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0F0F0F), // Deep Black
      Color(0xFF1A0B2E), // Dark Purple
      Color(0xFF2E1065), // Rich Violet (Subtle)
      Color(0xFF0F0F0F), // Deep Black
    ],
    stops: [0.0, 0.4, 0.7, 1.0],
  );

  // Light Theme Palette
  static const Color lightPrimaryColor = Color(0xFFA855F7); // Vivid Purple
  static const Color lightAccentColor = Color(0xFFD8B4FE); // Lavender
  static const Color lightBackgroundColor = Color(0xFFF8FAFC); // Off White/Slate 50
  static const Color lightSurfaceColor = Color(0xFFFFFFFF); // White Surface
  static const Color lightOnBackground = Colors.black87;

  // Light Gradient: White -> Soft Lavender -> White
  static const LinearGradient lightBackgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFFFFF), // White
      Color(0xFFF3E8FF), // Pale Purple
      Color(0xFFE9D5FF), // Light Purple
      Color(0xFFFFFFFF), // White
    ],
    stops: [0.0, 0.4, 0.7, 1.0],
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBackgroundColor,
      primaryColor: lightPrimaryColor,
      canvasColor: lightSurfaceColor,
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.light().textTheme,
      ).copyWith(
        displayLarge: const TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.0,
          color: Colors.black87,
          height: 1.1,
        ),
        displayMedium: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5,
          color: Colors.black87,
        ),
        headlineSmall: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
        bodyLarge: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black54),
        bodyMedium: const TextStyle(fontSize: 14, height: 1.4, color: Colors.black45),
      ),
      colorScheme: const ColorScheme.light(
        primary: lightPrimaryColor,
        secondary: lightAccentColor,
        surface: lightSurfaceColor,
        background: lightBackgroundColor,
        onBackground: lightOnBackground,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: lightPrimaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: primaryColor,
      canvasColor: surfaceColor,
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.dark().textTheme,
      ).copyWith(
        displayLarge: const TextStyle(
          fontSize: 48, // More compact
          fontWeight: FontWeight.w700, 
          letterSpacing: -1.0,
          color: Colors.white,
          height: 1.1,
        ),
        displayMedium: const TextStyle(
          fontSize: 32, 
          fontWeight: FontWeight.w600, 
          letterSpacing: -0.5,
          color: Colors.white,
        ),
        headlineSmall: const TextStyle(
          fontSize: 20, 
          fontWeight: FontWeight.w600, 
          color: Colors.white,
        ),
        bodyLarge: const TextStyle(fontSize: 16, height: 1.5, color: Colors.white70),
        bodyMedium: const TextStyle(fontSize: 14, height: 1.4, color: Colors.white60),
      ),
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: accentColor,
        surface: surfaceColor,
        background: backgroundColor,
        onBackground: onBackground,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white, // White text on purple button
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),
    );
  }
  static LinearGradient getBackgroundGradient(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? backgroundGradient
        : lightBackgroundGradient;
  }
}


