import 'package:flutter/material.dart';
import '../theme/app_text_styles.dart';

enum CustomTextVariant { h1, h2, h3, body, bodyMuted, caption, label, stat }

/// Central text widget so every screen pulls typography from one place
/// instead of hand-rolling TextStyles inline.
class CustomText extends StatelessWidget {
  final String text;
  final CustomTextVariant variant;
  final Color? color;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontWeight? weight;

  const CustomText(
    this.text, {
    super.key,
    this.variant = CustomTextVariant.body,
    this.color,
    this.align,
    this.maxLines,
    this.overflow,
    this.weight,
  });

  TextStyle get _baseStyle {
    switch (variant) {
      case CustomTextVariant.h1:
        return AppTextStyles.h1;
      case CustomTextVariant.h2:
        return AppTextStyles.h2;
      case CustomTextVariant.h3:
        return AppTextStyles.h3;
      case CustomTextVariant.bodyMuted:
        return AppTextStyles.bodyMuted;
      case CustomTextVariant.caption:
        return AppTextStyles.caption;
      case CustomTextVariant.label:
        return AppTextStyles.label;
      case CustomTextVariant.stat:
        return AppTextStyles.statNumber;
      case CustomTextVariant.body:
        return AppTextStyles.body;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow ?? (maxLines != null ? TextOverflow.ellipsis : null),
      style: _baseStyle.copyWith(
        color: color ?? _baseStyle.color,
        fontWeight: weight ?? _baseStyle.fontWeight,
      ),
    );
  }
}
