import 'package:flutter/material.dart';

/// Design tokens for the app.
/// Palette moves away from the generic "near-black + acid green" fitness
/// template: a warm plum-charcoal base with a coral accent for energy
/// (calories/workouts) and a teal accent for recovery data (water/rest),
/// so the two metric families are visually distinct at a glance.
class AppColors {
  AppColors._();

  static const Color background = Color(0xFF14121A);
  static const Color surface = Color(0xFF1E1B26);
  static const Color surfaceElevated = Color(0xFF262231);
  static const Color divider = Color(0xFF2E2A3A);

  static const Color primary = Color(0xFFFF6B4A); // coral - energy/calories
  static const Color primarySoft = Color(0xFFFF8A6E);
  static const Color secondary = Color(0xFF3ED9C4); // teal - water/recovery
  static const Color tertiary = Color(0xFFFFC857); // amber - steps/streaks
  static const Color success = Color(0xFF6FCF97);
  static const Color danger = Color(0xFFEF5A6F);

  static const Color textPrimary = Color(0xFFF5F3F7);
  static const Color textMuted = Color(0xFF9B96A8);
  static const Color textFaint = Color(0xFF69647A);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFFF6B4A), Color(0xFFFF9166)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [Color(0xFF3ED9C4), Color(0xFF63E6D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static Color categoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'chest':
        return primary;
      case 'back':
        return secondary;
      case 'shoulders':
        return tertiary;
      case 'arms':
        return const Color(0xFFB98CFF);
      case 'legs':
        return const Color(0xFF6FCF97);
      case 'abs':
        return const Color(0xFFEF5A6F);
      case 'cardio':
        return primary;
      case 'yoga':
        return secondary;
      case 'hiit':
        return const Color(0xFFEF5A6F);
      case 'stretching':
        return const Color(0xFFB98CFF);
      case 'full body':
        return tertiary;
      default:
        return primary;
    }
  }
}
