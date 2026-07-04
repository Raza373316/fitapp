import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/exercise_model.dart';
import '../../workouts/providers/workout_providers.dart';

/// Holds the set of favorited exercise IDs. Kept separate from ExerciseModel
/// itself (which is immutable) so "favorite" is app state, not data - this
/// is also where you'd sync to Firestore per-user later.
class FavoritesNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => <String>{};

  void toggle(String exerciseId) {
    final updated = {...state};
    if (!updated.remove(exerciseId)) {
      updated.add(exerciseId);
    }
    state = updated;
  }

  bool isFavorite(String exerciseId) => state.contains(exerciseId);
}

final favoriteIdsProvider = NotifierProvider<FavoritesNotifier, Set<String>>(
  FavoritesNotifier.new,
);

/// Derived list of full ExerciseModel objects that are currently favorited -
/// what the Favorites screen actually renders.
final favoriteExercisesProvider = Provider<List<ExerciseModel>>((ref) {
  final ids = ref.watch(favoriteIdsProvider);
  final all = ref.watch(allExercisesProvider);
  return all.where((e) => ids.contains(e.id)).toList();
});
