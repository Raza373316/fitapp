import 'package:flutter/material.dart';
import '../../data/models/category_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_shadows.dart';
import 'custom_text.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;
  final bool compact;

  const CategoryCard({
    super.key,
    required this.category,
    required this.onTap,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppColors.categoryColor(category.name);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: compact ? 82 : null,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.divider),
        boxShadow: AppShadows.card,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(category.icon, color: color, size: 22),
            ),
            const SizedBox(height: 10),
            CustomText(
              category.name,
              variant: CustomTextVariant.body,
              weight: FontWeight.w600,
              align: TextAlign.center,
              maxLines: 1,
            ),
            if (!compact) ...[
              const SizedBox(height: 2),
              CustomText(
                '${category.exerciseCount} exercises',
                variant: CustomTextVariant.caption,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
