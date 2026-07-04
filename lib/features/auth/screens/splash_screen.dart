import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_text.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.fitness_center, color: Colors.white, size: 38),
            ),
            const SizedBox(height: 20),
            const CustomText('Fit Peak', variant: CustomTextVariant.h1),
            const SizedBox(height: 6),
            const CustomText('Push your limits.', variant: CustomTextVariant.bodyMuted),
            const SizedBox(height: 28),
            const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(strokeWidth: 2.4, color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
