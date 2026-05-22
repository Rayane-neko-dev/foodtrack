import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryGreen = Color(0xFF4A7C3F);
  static const Color lightGreen = Color(0xFFD4E8C2);
  static const Color backgroundGreen = Color(0xFFEAF2E3);
  static const Color darkGreen = Color(0xFF2D5A1F);
  static const Color accentGreen = Color(0xFF6AAF56);
  static const Color headerGreen = Color(0xFF5A8F4A);
  static const Color expiringSoonRed = Color(0xFFE53E3E);
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textGrey = Color(0xFF6B6B6B);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color sectionLabel = Color(0xFF4A4A4A);

  static ThemeData get theme => ThemeData(
        primaryColor: primaryGreen,
        scaffoldBackgroundColor: backgroundGreen,
        colorScheme: const ColorScheme.light(
          primary: primaryGreen,
          secondary: accentGreen,
          surface: cardWhite,
        ),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryGreen,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFD0D0D0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFD0D0D0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: primaryGreen, width: 2),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          hintStyle: const TextStyle(color: Color(0xFF9E9E9E), fontSize: 14),
        ),
      );

  static const List<String> categories = [
    'Fruits',
    'Vegetables',
    'Dairy',
    'Meat',
    'Pasta',
    'Drinks',
    'Snacks',
    'Frozen',
    'Other',
  ];

  static const List<String> locations = [
    'Fridge',
    'Freezer',
    'Pantry',
    'Counter',
  ];

  // Category emoji icons
  static String categoryIcon(String category) {
    switch (category) {
      case 'Fruits': return '🍎';
      case 'Vegetables': return '🥦';
      case 'Dairy': return '🥛';
      case 'Meat': return '🥩';
      case 'Pasta': return '🍝';
      case 'Drinks': return '🧃';
      case 'Snacks': return '🍿';
      case 'Frozen': return '🧊';
      default: return '🛒';
    }
  }
}