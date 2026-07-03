import 'package:flutter/material.dart';
import '../../data/dummy_data.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/category_card.dart';
import 'exercise_list_screen.dart';

class WorkoutCategoriesScreen extends StatelessWidget {
  const WorkoutCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText('Workout Categories', variant: CustomTextVariant.h2),
      ),
      body: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          itemCount: DummyData.allCategories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (_, i) {
            final cat = DummyData.allCategories[i];
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
