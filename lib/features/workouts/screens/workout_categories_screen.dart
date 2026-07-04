import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/category_card.dart';
import '../../../core/widgets/custom_text.dart';
import '../providers/workout_providers.dart';
import 'exercise_list_screen.dart';
class WorkoutCategoriesScreen extends ConsumerWidget {
  const WorkoutCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(allCategoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const CustomText('Workout Categories', variant: CustomTextVariant.h2),
      ),
      body: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (_, i) {
            final cat = categories[i];
            return CategoryCard(
              category: cat,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ExerciseListScreen(category: cat.name)),
              ),
            );
          },
        ),
      ),
    );
  }
}
