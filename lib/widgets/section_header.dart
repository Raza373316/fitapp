import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'custom_text.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(title, variant: CustomTextVariant.h2),
        if (actionLabel != null)
          GestureDetector(
            onTap: onAction,
            child: Row(
              children: [
                CustomText(actionLabel!,
                    variant: CustomTextVariant.body,
                    color: AppColors.primary,
                    weight: FontWeight.w600),
                const Icon(Icons.chevron_right, size: 16, color: AppColors.primary),
              ],
            ),
          ),
      ],
    );
  }
}
