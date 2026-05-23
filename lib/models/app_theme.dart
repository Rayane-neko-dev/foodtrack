import 'package:flutter/material.dart';

class AppTheme {

  // ================= COLORS =================

  static const cardColor = Colors.white;

  static const Color primaryGreen = Color(0xFF4CAF50);

  static const Color darkGreen = Color(0xFF2E7D32);

  static const Color lightGreen = Color(0xFFE8F5E9);

  static const Color backgroundGreen = Color(0xFFF4FFF4);

  static const Color accentGreen = Color(0xFF81C784);

  static const Color textDark = Color(0xFF1B1B1B);

  static const Color textGrey = Color(0xFF777777);

  static const Color expiringSoonRed = Color(0xFFE53935);

  // ================= CATEGORIES =================

  static const List<String> categories = [

    "Fruits",

    "Vegetables",

    "Dairy",

    "Meat",

    "Fish",

    "Drinks",

    "Snacks",

    "Frozen",

    "Pasta",

    "Rice",

    "Bakery",

    "Canned",

    "Other",
  ];

  // ================= STORAGE LOCATIONS =================

  static const List<String> locations = [

    "Fridge",

    "Freezer",

    "Pantry",

    "Counter",

    "Cabinet",
  ];

  // ================= CATEGORY ICONS =================

  static String categoryIcon(String category) {

    switch (category) {

      case "Fruits":
        return "🍎";

      case "Vegetables":
        return "🥦";

      case "Dairy":
        return "🥛";

      case "Meat":
        return "🥩";

      case "Fish":
        return "🐟";

      case "Drinks":
        return "🥤";

      case "Snacks":
        return "🍪";

      case "Frozen":
        return "🧊";

      case "Pasta":
        return "🍝";

      case "Rice":
        return "🍚";

      case "Bakery":
        return "🍞";

      case "Canned":
        return "🥫";

      default:
        return "🍽️";
    }
  }
}