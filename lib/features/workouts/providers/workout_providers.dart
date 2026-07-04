import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/dummy_data.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/exercise_model.dart';

/// Data-layer providers. These wrap DummyData today; swapping in Firestore
/// later means changing only this file - screens never import DummyData
/// directly.
final homeCategoriesProvider = Provider<List<CategoryModel>>((ref) => DummyData.homeCategories);

final allCategoriesProvider = Provider<List<CategoryModel>>((ref) => DummyData.allCategories);

final allExercisesProvider = Provider<List<ExerciseModel>>((ref) => DummyData.exercises);

final popularExercisesProvider = Provider<List<ExerciseModel>>((ref) => DummyData.popularExercises);

final exercisesByCategoryProvider = Provider.family<List<ExerciseModel>, String>((ref, category) {
  return ref.watch(allExercisesProvider).where((e) => e.category == category).toList();
});
