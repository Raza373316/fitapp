import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../workouts/providers/workout_providers.dart';
import '../models/custom_workout_model.dart';
import '../providers/custom_workout_providers.dart';

class CustomWorkoutScreen extends ConsumerWidget {
  const CustomWorkoutScreen({super.key});

  void _createWorkout(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          left: 20, right: 20, top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText('New Workout', variant: CustomTextVariant.h2),
            const SizedBox(height: 16),
            CustomTextField(hint: 'Workout name', controller: controller),
            const SizedBox(height: 20),
            CustomButton(
              label: 'Create Workout',
              onPressed: () {
                if (controller.text.trim().isEmpty) return;
                ref.read(customWorkoutsProvider.notifier).create(controller.text.trim());
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _renameWorkout(BuildContext context, WidgetRef ref, CustomWorkoutModel w) {
    final controller = TextEditingController(text: w.name);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const CustomText('Rename Workout', variant: CustomTextVariant.h3),
        content: CustomTextField(hint: 'Workout name', controller: controller),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                ref.read(customWorkoutsProvider.notifier).rename(w.id, controller.text.trim());
              }
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _addExercise(BuildContext context, WidgetRef ref, CustomWorkoutModel w) {
    final exercises = ref.read(allExercisesProvider);
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => SizedBox(
        height: 420,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: CustomText('Add Exercise', variant: CustomTextVariant.h2),
            ),
            Expanded(
              child: Consumer(
                builder: (context, ref, _) {
                  final workouts = ref.watch(customWorkoutsProvider);
                  final current = workouts.firstWhere((x) => x.id == w.id, orElse: () => w);
                  return ListView.builder(
                    itemCount: exercises.length,
                    itemBuilder: (_, i) {
                      final ex = exercises[i];
                      final added = current.exerciseIds.contains(ex.id);
                      return ListTile(
                        title: CustomText(ex.name, variant: CustomTextVariant.body),
                        subtitle: CustomText(ex.category, variant: CustomTextVariant.caption),
                        trailing: Icon(
                          added ? Icons.check_circle : Icons.add_circle_outline,
                          color: added ? AppColors.success : AppColors.primary,
                        ),
                        onTap: () => ref
                            .read(customWorkoutsProvider.notifier)
                            .toggleExercise(w.id, ex.id),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workouts = ref.watch(customWorkoutsProvider);

    return Scaffold(
      appBar: AppBar(title: const CustomText('Custom Workouts', variant: CustomTextVariant.h2)),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => _createWorkout(context, ref),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: workouts.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 84,
                      height: 84,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.playlist_add, size: 34, color: AppColors.primary),
                    ),
                    const SizedBox(height: 16),
                    const CustomText('No custom workouts yet', variant: CustomTextVariant.h3),
                    const SizedBox(height: 4),
                    const CustomText('Tap + to build your own routine',
                        variant: CustomTextVariant.bodyMuted),
                  ],
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                itemCount: workouts.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) => _workoutCard(context, ref, workouts[i]),
              ),
      ),
    );
  }

  Widget _workoutCard(BuildContext context, WidgetRef ref, CustomWorkoutModel w) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.divider),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: CustomText(w.name, variant: CustomTextVariant.h3)),
              IconButton(
                onPressed: () => _renameWorkout(context, ref, w),
                icon: const Icon(Icons.edit_outlined, size: 18, color: AppColors.textMuted),
              ),
              IconButton(
                onPressed: () => ref.read(customWorkoutsProvider.notifier).delete(w.id),
                icon: const Icon(Icons.delete_outline, size: 18, color: AppColors.danger),
              ),
            ],
          ),
          CustomText('${w.exerciseIds.length} exercises', variant: CustomTextVariant.caption),
          const SizedBox(height: 12),
          CustomButton(
            label: 'Add Exercise',
            variant: CustomButtonVariant.outline,
            icon: Icons.add,
            height: 44,
            onPressed: () => _addExercise(context, ref, w),
          ),
        ],
      ),
    );
  }
}
