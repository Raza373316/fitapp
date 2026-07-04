import 'package:flutter/material.dart';

class AppShadows {
  AppShadows._();

  /// Soft ambient shadow used on surface cards to lift them off the
  /// background instead of relying only on a hairline border.
  static List<BoxShadow> card = [
    BoxShadow(
      color: Colors.black.withOpacity(0.28),
      blurRadius: 20,
      offset: const Offset(0, 10),
    ),
  ];

  static List<BoxShadow> glow(Color color) => [
        BoxShadow(
          color: color.withOpacity(0.35),
          blurRadius: 24,
          offset: const Offset(0, 12),
        ),
      ];

  static List<BoxShadow> nav = [
    BoxShadow(
      color: Colors.black.withOpacity(0.4),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];
}
