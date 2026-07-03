import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

enum CustomButtonVariant { primary, secondary, outline, ghost, danger }

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final CustomButtonVariant variant;
  final IconData? icon;
  final bool fullWidth;
  final bool loading;
  final double height;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = CustomButtonVariant.primary,
    this.icon,
    this.fullWidth = true,
    this.loading = false,
    this.height = 54,
  });

  @override
  Widget build(BuildContext context) {
    final child = loading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.4,
              color: variant == CustomButtonVariant.outline ||
                      variant == CustomButtonVariant.ghost
                  ? AppColors.primary
                  : Colors.white,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: _fgColor),
                const SizedBox(width: 8),
              ],
              Text(label, style: AppTextStyles.button.copyWith(color: _fgColor)),
            ],
          );

    final button = switch (variant) {
      CustomButtonVariant.primary => Ink(
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(16),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: loading ? null : onPressed,
            child: Container(
              height: height,
              alignment: Alignment.center,
              child: child,
            ),
          ),
        ),
      CustomButtonVariant.secondary => Container(
          height: height,
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: loading ? null : onPressed,
              child: Center(child: child),
            ),
          ),
        ),
      CustomButtonVariant.outline => Container(
          height: height,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.divider, width: 1.4),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: loading ? null : onPressed,
              child: Center(child: child),
            ),
          ),
        ),
      CustomButtonVariant.ghost => SizedBox(
          height: height,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: loading ? null : onPressed,
              child: Center(child: child),
            ),
          ),
        ),
      CustomButtonVariant.danger => Container(
          height: height,
          decoration: BoxDecoration(
            color: AppColors.danger.withOpacity(0.15),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: loading ? null : onPressed,
              child: Center(child: child),
            ),
          ),
        ),
    };

    return fullWidth ? SizedBox(width: double.infinity, child: button) : button;
  }

  Color get _fgColor {
    switch (variant) {
      case CustomButtonVariant.outline:
        return AppColors.textPrimary;
      case CustomButtonVariant.ghost:
        return AppColors.primary;
      case CustomButtonVariant.danger:
        return AppColors.danger;
      default:
        return Colors.white;
    }
  }
}
