import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/exercise_card.dart';
import '../../favorites/providers/favorites_providers.dart';
import '../providers/workout_providers.dart';
import 'exercise_detail_screen.dart';

class ExerciseListScreen extends ConsumerWidget {
  final String category;
  const ExerciseListScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercises = ref.watch(exercisesByCategoryProvider(category));
    final favoriteIds = ref.watch(favoriteIdsProvider);

    return Scaffold(
      appBar: AppBar(
        title: CustomText(category, variant: CustomTextVariant.h2),
      ),
      body: SafeArea(
        child: exercises.isEmpty
            ? Center(
                child: CustomText(
                  'No exercises yet for $category.',
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
                    isFavorite: favoriteIds.contains(ex.id),
                    onFavoriteToggle: () => ref.read(favoriteIdsProvider.notifier).toggle(ex.id),
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
