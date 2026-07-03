import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/custom_text.dart';
import '../favorites/favorites_screen.dart';
import '../custom_workout/custom_workout_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
        children: [
          const CustomText('Profile', variant: CustomTextVariant.h1),
          const SizedBox(height: 24),
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Text('MR',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20)),
              ),
              const SizedBox(width: 14),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText('Muhammad Raza', variant: CustomTextVariant.h2),
                  CustomText('Flutter Developer · Rawalpindi', variant: CustomTextVariant.bodyMuted),
                ],
              ),
            ],
          ),
          const SizedBox(height: 28),
          _menuTile(
            context,
            icon: Icons.favorite_border,
            label: 'Favorites',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoritesScreen())),
          ),
          _menuTile(
            context,
            icon: Icons.playlist_add_check_circle_outlined,
            label: 'Custom Workouts',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomWorkoutScreen())),
          ),
          _menuTile(context, icon: Icons.notifications_none, label: 'Notifications', onTap: () {}),
          _menuTile(context, icon: Icons.settings_outlined, label: 'Settings', onTap: () {}),
          _menuTile(context, icon: Icons.help_outline, label: 'Help & Support', onTap: () {}),
          _menuTile(context, icon: Icons.logout, label: 'Log Out', onTap: () {}, danger: true),
        ],
      ),
    );
  }

  Widget _menuTile(BuildContext context,
      {required IconData icon, required String label, required VoidCallback onTap, bool danger = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.divider),
        boxShadow: AppShadows.card,
          ),
          child: Row(
            children: [
              Icon(icon, size: 20, color: danger ? AppColors.danger : AppColors.textMuted),
              const SizedBox(width: 14),
              CustomText(label, variant: CustomTextVariant.body,
                  color: danger ? AppColors.danger : AppColors.textPrimary, weight: FontWeight.w600),
              const Spacer(),
              const Icon(Icons.chevron_right, size: 18, color: AppColors.textFaint),
            ],
          ),
        ),
      ),
    );
  }
}
