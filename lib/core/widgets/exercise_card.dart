import 'package:flutter/material.dart';
import '../../data/models/exercise_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_shadows.dart';
import 'custom_text.dart';

class ExerciseCard extends StatelessWidget {
  final ExerciseModel exercise;
  final VoidCallback onTap;
  final VoidCallback? onFavoriteToggle;
  final bool isFavorite;
  final bool horizontal;

  const ExerciseCard({
    super.key,
    required this.exercise,
    required this.onTap,
    this.onFavoriteToggle,
    this.isFavorite = false,
    this.horizontal = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppColors.categoryColor(exercise.category);

    final thumb = Container(
      height: horizontal ? 96 : 110,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.35), color.withOpacity(0.08)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(Icons.fitness_center, color: color, size: 34),
    );

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: CustomText(exercise.name,
                  variant: CustomTextVariant.h3, maxLines: 1),
            ),
            if (onFavoriteToggle != null)
              GestureDetector(
                onTap: onFavoriteToggle,
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  size: 18,
                  color: isFavorite ? AppColors.danger : AppColors.textMuted,
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: [
            _tag(exercise.difficulty, color),
            _tag('${exercise.calories} kcal', AppColors.tertiary),
            _tag(exercise.duration, AppColors.secondary),
          ],
        ),
      ],
    );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: horizontal ? 168 : null,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.divider),
        boxShadow: AppShadows.card,
        ),
        child: horizontal
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [thumb, const SizedBox(height: 10), content],
              )
            : Row(
                children: [
                  SizedBox(width: 84, child: thumb),
                  const SizedBox(width: 12),
                  Expanded(child: content),
                ],
              ),
      ),
    );
  }

  Widget _tag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.14),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 10.5, color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}
