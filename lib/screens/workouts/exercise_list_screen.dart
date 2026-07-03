import 'package:flutter/material.dart';
import '../../data/dummy_data.dart';
import '../../models/exercise_model.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/exercise_card.dart';
import 'exercise_detail_screen.dart';

class ExerciseListScreen extends StatefulWidget {
  final String category;
  const ExerciseListScreen({super.key, required this.category});

  @override
  State<ExerciseListScreen> createState() => _ExerciseListScreenState();
}

class _ExerciseListScreenState extends State<ExerciseListScreen> {
  late List<ExerciseModel> exercises;

  @override
  void initState() {
    super.initState();
    exercises = DummyData.exercisesByCategory(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(widget.category, variant: CustomTextVariant.h2),
      ),
      body: SafeArea(
        child: exercises.isEmpty
            ? Center(
                child: CustomText(
                  'No exercises yet for ${widget.category}.',
                  variant: CustomTextVariant.bodyMuted,
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                itemCount: exercises.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) {
                  final ex = exercises[i];
                  return ExerciseCard(
                    exercise: ex,
                    onFavoriteToggle: () => setState(() => ex.isFavorite = !ex.isFavorite),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ExerciseDetailScreen(exercise: ex)),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
