import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Vibrant Color Palette
  static const primaryColor = Color(0xFF6C5CE7); // Vibrant Purple
  static const secondaryColor = Color(0xFFFF6B9D); // Pink
  static const accentColor = Color(0xFF00D4FF); // Cyan
  static const backgroundColor = Color(0xFFF8F9FE); // Light Purple-tinted
  static const cardColor = Colors.white;

  // Gradient Colors
  static const gradientStart = Color(0xFF667EEA);
  static const gradientEnd = Color(0xFF764BA2);

  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      secondary: secondaryColor,
      surface: backgroundColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      outlineVariant: Colors.grey[200],
    ),
    scaffoldBackgroundColor: backgroundColor,
    textTheme: GoogleFonts.outfitTextTheme().apply(
      bodyColor: const Color(0xFF2D3436),
      displayColor: const Color(0xFF2D3436),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundColor,
      elevation: 0,
      centerTitle: false,
      iconTheme: const IconThemeData(color: primaryColor),
      titleTextStyle: GoogleFonts.outfit(
        color: const Color(0xFF2D3436),
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
 
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        textStyle: GoogleFonts.outfit(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: const BorderSide(color: primaryColor, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        textStyle: GoogleFonts.outfit(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      prefixIconColor: primaryColor,
      suffixIconColor: primaryColor,
      hintStyle: TextStyle(color: Colors.grey[400]),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey[200]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      contentPadding: const EdgeInsets.all(20),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
  );

  // Gradient Decoration
  static BoxDecoration get primaryGradient => BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [gradientStart, gradientEnd],
    ),
  );

  // Card with subtle gradient
  static BoxDecoration get cardGradient => BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.white, primaryColor.withValues(alpha: 0.05)],
    ),
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: primaryColor.withValues(alpha: 0.1),
        blurRadius: 20,
        offset: const Offset(0, 10),
      ),
    ],
  );
}
