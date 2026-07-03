import 'package:flutter/material.dart';
import '../../models/exercise_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_button.dart';
import 'active_workout_screen.dart';

class ExerciseDetailScreen extends StatefulWidget {
  final ExerciseModel exercise;
  const ExerciseDetailScreen({super.key, required this.exercise});

  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final ex = widget.exercise;
    final color = AppColors.categoryColor(ex.category);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: false,
                  backgroundColor: AppColors.background,
                  expandedHeight: 260,
                  automaticallyImplyLeading: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [color.withOpacity(0.55), color.withOpacity(0.08)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Icon(Icons.fitness_center, color: Colors.white.withOpacity(0.9), size: 80),
                        ),
                        Positioned(
                          left: 0, right: 0, bottom: 0,
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [AppColors.background, AppColors.background.withOpacity(0)],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),
                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Row(
                              children: [
                                _circleIconButton(
                                  icon: Icons.arrow_back,
                                  onTap: () => Navigator.pop(context),
                                ),
                                const Spacer(),
                                _circleIconButton(
                                  icon: ex.isFavorite ? Icons.favorite : Icons.favorite_border,
                                  iconColor: ex.isFavorite ? AppColors.danger : Colors.white,
                                  onTap: () => setState(() => ex.isFavorite = !ex.isFavorite),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                  CustomText(ex.name, variant: CustomTextVariant.h1),
                  const SizedBox(height: 4),
                  CustomText(ex.category, variant: CustomTextVariant.bodyMuted),
                  const SizedBox(height: 18),
                  _quickStatsRow(ex, color),
                  const SizedBox(height: 22),
                  _infoRow('Equipment', ex.equipment),
                  _infoRow('Target Muscle', ex.muscle),
                  const SizedBox(height: 8),
                  const CustomText('Benefits', variant: CustomTextVariant.h3),
                  const SizedBox(height: 6),
                  CustomText(ex.benefits, variant: CustomTextVariant.bodyMuted),
                  const SizedBox(height: 20),
                  const CustomText('Instructions', variant: CustomTextVariant.h3),
                  const SizedBox(height: 10),
                  ...List.generate(ex.instructions.length, (i) => _instructionStep(i, ex.instructions[i])),
                  const SizedBox(height: 20),
                  _setsRepsRestRow(ex, color),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            decoration: const BoxDecoration(
              color: AppColors.background,
              border: Border(top: BorderSide(color: AppColors.divider)),
            ),
            child: SafeArea(
              top: false,
              child: CustomButton(
                label: 'Start Workout',
                icon: Icons.play_arrow_rounded,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ActiveWorkoutScreen(exercise: ex)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleIconButton({
    required IconData icon,
    required VoidCallback onTap,
    Color iconColor = Colors.white,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.28),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 19),
      ),
    );
  }

  Widget _quickStatsRow(ExerciseModel ex, Color color) {
    Widget stat(IconData icon, String value, String label) {
      return Expanded(
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 6),
            CustomText(value, variant: CustomTextVariant.h3),
            CustomText(label, variant: CustomTextVariant.caption),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.divider),
        boxShadow: AppShadows.card,
      ),
      child: Row(
        children: [
          stat(Icons.bar_chart, ex.difficulty, 'Difficulty'),
          stat(Icons.local_fire_department_outlined, '${ex.calories}', 'Calories'),
          stat(Icons.timer_outlined, ex.duration, 'Duration'),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: CustomText(label, variant: CustomTextVariant.bodyMuted),
          ),
          Expanded(child: CustomText(value, variant: CustomTextVariant.body, weight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _instructionStep(int index, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: CustomText('${index + 1}', variant: CustomTextVariant.caption, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(child: CustomText(text, variant: CustomTextVariant.body)),
        ],
      ),
    );
  }

  Widget _setsRepsRestRow(ExerciseModel ex, Color color) {
    Widget chip(String label, String value) {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              CustomText(value, variant: CustomTextVariant.h3, color: color),
              CustomText(label, variant: CustomTextVariant.caption),
            ],
          ),
        ),
      );
    }

    return Row(
      children: [
        chip('Sets', '${ex.sets}'),
        chip('Reps', ex.reps),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                CustomText(ex.restTime, variant: CustomTextVariant.h3, color: color),
                const CustomText('Rest', variant: CustomTextVariant.caption),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
