import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/widgets/custom_text.dart';
import '../../auth/providers/auth_providers.dart';
import '../../custom_workout/screens/custom_workout_screen.dart';
import '../../favorites/screens/favorites_screen.dart';
import '../provider/userprofileprovider.dart';
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(userProfileProvider);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
        children: [
          const CustomText('Profile', variant: CustomTextVariant.h1),
          const SizedBox(height: 24),
          profileAsync.when(
            data: (user) => _profileHeader(
              name: user?.name ?? 'No name set',
              subtitle: user != null
                  ? '${user.gender} · ${user.email}'
                  : 'Complete your profile',
            ),
            loading: () => _profileHeader(name: 'Loading...', subtitle: ''),
            error: (e, _) => _profileHeader(name: 'Could not load profile', subtitle: '$e'),
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
          _menuTile(
            context,
            icon: Icons.logout,
            label: 'Log Out',
            danger: true,
            onTap: () => ref.read(authControllerProvider.notifier).logout(),
            // AuthGate is watching authStateChangesProvider at the app root,
            // so signing out here automatically swaps the UI back to Login.
          ),
        ],
      ),
    );
  }

  Widget _profileHeader({required String name, required String subtitle}) {
    final initials = name.trim().isEmpty
        ? '?'
        : name.trim().split(RegExp(r'\s+')).take(2).map((w) => w[0].toUpperCase()).join();

    return Row(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(initials,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20)),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(name, variant: CustomTextVariant.h2, maxLines: 1),
              if (subtitle.isNotEmpty)
                CustomText(subtitle, variant: CustomTextVariant.bodyMuted, maxLines: 1),
            ],
          ),
        ),
      ],
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