import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/widgets/category_card.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/exercise_card.dart';
import '../../../core/widgets/momentum_stat_card.dart';
import '../../../core/widgets/section_header.dart';
import '../../../data/dummy_data.dart';
import '../../favorites/providers/favorites_providers.dart';
import '../../profile/provider/userprofileprovider.dart';
import '../../workouts/providers/workout_providers.dart';
import '../../workouts/screens/exercise_detail_screen.dart';
import '../../workouts/screens/exercise_list_screen.dart';
import '../../workouts/screens/workout_categories_screen.dart';
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(homeCategoriesProvider);
    final popular = ref.watch(popularExercisesProvider);
    final favoriteIds = ref.watch(favoriteIdsProvider);
    final profileAsync = ref.watch(userProfileProvider);
    final name = profileAsync.when(
      data: (user) => user?.name ?? 'there',
      loading: () => '...',
      error: (_, __) => 'there',
    );

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
        children: [
          _greeting(name),
          const SizedBox(height: 24),
          const CustomText("Today's Progress", variant: CustomTextVariant.h2),
          const SizedBox(height: 12),
          _progressGrid(),
          const SizedBox(height: 28),
          SectionHeader(
            title: 'Workout Categories',
            actionLabel: 'See all',
            onAction: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const WorkoutCategoriesScreen())),
          ),
          const SizedBox(height: 14),
          _categoriesRow(context, categories),
          const SizedBox(height: 28),
          const SectionHeader(title: 'Popular Exercises'),
          const SizedBox(height: 14),
          _popularExercises(context, ref, popular, favoriteIds),
          const SizedBox(height: 28),
          _quoteCard(),
        ],
      ),
    );
  }

  Widget _greeting(String name) {
    final initials = name.trim().isEmpty || name == 'there' || name == '...'
        ? '?'
        : name.trim().split(RegExp(r'\s+')).take(2).map((w) => w[0].toUpperCase()).join();

    return Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            shape: BoxShape.circle,
            boxShadow: AppShadows.glow(AppColors.primary),
          ),
          alignment: Alignment.center,
          child: Text(initials,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText('Good Morning 👋', variant: CustomTextVariant.bodyMuted),
              const SizedBox(height: 2),
              CustomText(name, variant: CustomTextVariant.h1, maxLines: 1),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.divider),
            boxShadow: AppShadows.card,
          ),
          child: Row(
            children: const [
              Icon(Icons.local_fire_department, color: AppColors.tertiary, size: 18),
              SizedBox(width: 4),
              CustomText('6', variant: CustomTextVariant.h3),
            ],
          ),
        ),
      ],
    );
  }

  Widget _progressGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        MomentumStatCard(
          label: 'CALORIES',
          value: '420',
          unit: 'kcal',
          progress: 0.6,
          color: AppColors.primary,
          icon: Icons.local_fire_department_outlined,
        ),
        MomentumStatCard(
          label: 'STEPS',
          value: '6,240',
          unit: 'steps',
          progress: 0.78,
          color: AppColors.tertiary,
          icon: Icons.directions_walk,
        ),
        MomentumStatCard(
          label: 'WATER',
          value: '1.4',
          unit: 'L',
          progress: 0.47,
          color: AppColors.secondary,
          icon: Icons.water_drop_outlined,
        ),
        MomentumStatCard(
          label: 'WORKOUT',
          value: '32',
          unit: 'min',
          progress: 0.53,
          color: const Color(0xFFB98CFF),
          icon: Icons.timer_outlined,
        ),
      ],
    );
  }

  Widget _categoriesRow(BuildContext context, List categories) {
    return SizedBox(
      height: 108,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, i) {
          final cat = categories[i];
          return CategoryCard(
            category: cat,
            compact: true,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ExerciseListScreen(category: cat.name),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _popularExercises(BuildContext context, WidgetRef ref, List popular, Set<String> favoriteIds) {
    return SizedBox(
      height: 232,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: popular.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) {
          final ex = popular[i];
          return ExerciseCard(
            exercise: ex,
            horizontal: true,
            isFavorite: favoriteIds.contains(ex.id),
            onFavoriteToggle: () => ref.read(favoriteIdsProvider.notifier).toggle(ex.id),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => ExerciseDetailScreen(exercise: ex))),
          );
        },
      ),
    );
  }

  Widget _quoteCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppShadows.glow(AppColors.primary),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -6,
            top: -18,
            child: Text(
              '"',
              style: TextStyle(
                fontSize: 90,
                fontWeight: FontWeight.w800,
                color: Colors.white.withOpacity(0.12),
                height: 1,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText("Today's Quote",
                  variant: CustomTextVariant.label, color: Colors.white70),
              const SizedBox(height: 8),
              CustomText(
                DummyData.quotes.first,
                variant: CustomTextVariant.h3,
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}