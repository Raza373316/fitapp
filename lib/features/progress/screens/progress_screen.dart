import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/widgets/custom_text.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  int _rangeIndex = 0; // 0 weekly, 1 monthly, 2 yearly
  final _ranges = ['Weekly', 'Monthly', 'Yearly'];

  final _weekly = [0.4, 0.6, 0.3, 0.8, 0.5, 0.9, 0.65];
  final _monthly = [0.5, 0.7, 0.4, 0.85];
  final _yearly = [0.3, 0.5, 0.6, 0.4, 0.7, 0.65, 0.8, 0.55, 0.6, 0.75, 0.5, 0.9];

  List<double> get _activeData {
    switch (_rangeIndex) {
      case 1:
        return _monthly;
      case 2:
        return _yearly;
      default:
        return _weekly;
    }
  }

  final _history = [
    ('Push Day', 'Today', '32 min', 320),
    ('Leg Day', 'Yesterday', '45 min', 410),
    ('Yoga Flow', '2 days ago', '25 min', 150),
    ('HIIT Blast', '4 days ago', '20 min', 280),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
        children: [
          const CustomText('Progress', variant: CustomTextVariant.h1),
          const SizedBox(height: 20),
          _statsGrid(),
          const SizedBox(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText('Activity', variant: CustomTextVariant.h2),
              _rangeSelector(),
            ],
          ),
          const SizedBox(height: 16),
          _chart(),
          const SizedBox(height: 28),
          const CustomText('Workout History', variant: CustomTextVariant.h2),
          const SizedBox(height: 14),
          ..._history.map(_historyTile),
        ],
      ),
    );
  }

  Widget _statsGrid() {
    final stats = [
      ('Current Weight', '74.2 kg', Icons.monitor_weight_outlined, AppColors.primary),
      ('Calories Burned', '1,240 kcal', Icons.local_fire_department_outlined, AppColors.tertiary),
      ('Workout Time', '4.2 hrs', Icons.timer_outlined, AppColors.secondary),
      ('Completed', '18 workouts', Icons.emoji_events_outlined, const Color(0xFFB98CFF)),
    ];
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: stats.map((s) {
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.divider),
        boxShadow: AppShadows.card,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(s.$3, color: s.$4, size: 20),
              const Spacer(),
              CustomText(s.$2, variant: CustomTextVariant.h3),
              CustomText(s.$1, variant: CustomTextVariant.caption),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _rangeSelector() {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
        boxShadow: AppShadows.card,
      ),
      child: Row(
        children: List.generate(_ranges.length, (i) {
          final selected = i == _rangeIndex;
          return GestureDetector(
            onTap: () => setState(() => _rangeIndex = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Text(
                _ranges[i],
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: selected ? Colors.white : AppColors.textMuted,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _chart() {
    final labels = switch (_rangeIndex) {
      1 => const ['W1', 'W2', 'W3', 'W4'],
      2 => const ['J', 'F', 'M', 'A', 'M', 'J', 'J', 'A', 'S', 'O', 'N', 'D'],
      _ => const ['M', 'T', 'W', 'T', 'F', 'S', 'S'],
    };
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 18, 14, 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.divider),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 120,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _activeData.map((v) {
                final isPeak = v == _activeData.reduce((a, b) => a > b ? a : b);
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: FractionallySizedBox(
                      heightFactor: v.clamp(0.05, 1.0),
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: isPeak
                                ? [AppColors.primary, AppColors.primarySoft]
                                : [AppColors.primary.withOpacity(0.35), AppColors.primary.withOpacity(0.15)],
                          ),
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: labels
                .map((l) => Expanded(
                      child: Center(
                        child: CustomText(l, variant: CustomTextVariant.caption),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _historyTile((String, String, String, int) item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
        boxShadow: AppShadows.card,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.14),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.fitness_center, color: AppColors.primary, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(item.$1, variant: CustomTextVariant.h3),
                CustomText('${item.$2} · ${item.$3}', variant: CustomTextVariant.caption),
              ],
            ),
          ),
          CustomText('${item.$4} kcal', variant: CustomTextVariant.body, color: AppColors.tertiary),
        ],
      ),
    );
  }
}
