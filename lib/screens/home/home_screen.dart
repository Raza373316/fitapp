import 'package:flutter/material.dart';
import '../../data/dummy_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/momentum_stat_card.dart';
import '../../widgets/category_card.dart';
import '../../widgets/exercise_card.dart';
import '../../widgets/section_header.dart';
import '../workouts/workout_categories_screen.dart';
import '../workouts/exercise_list_screen.dart';
import '../workouts/exercise_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
        children: [
          _greeting(),
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
          _categoriesRow(context),
          const SizedBox(height: 28),
          const SectionHeader(title: 'Popular Exercises'),
          const SizedBox(height: 14),
          _popularExercises(context),
          const SizedBox(height: 28),
          _quoteCard(),
        ],
      ),
    );
  }

  Widget _greeting() {
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
          child: const Text('MR',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CustomText('Good Morning 👋', variant: CustomTextVariant.bodyMuted),
              SizedBox(height: 2),
              CustomText('Muhammad Raza', variant: CustomTextVariant.h1),
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
      children: const [
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
          color: Color(0xFFB98CFF),
          icon: Icons.timer_outlined,
        ),
      ],
    );
  }

  Widget _categoriesRow(BuildContext context) {
    return SizedBox(
      height: 108,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: DummyData.homeCategories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, i) {
          final cat = DummyData.homeCategories[i];
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

  Widget _popularExercises(BuildContext context) {
    return SizedBox(
      height: 232,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: DummyData.popularExercises.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) {
          final ex = DummyData.popularExercises[i];
          return ExerciseCard(
            exercise: ex,
            horizontal: true,
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
