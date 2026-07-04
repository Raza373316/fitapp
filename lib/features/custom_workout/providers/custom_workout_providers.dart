import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/custom_workout_model.dart';

class CustomWorkoutsNotifier extends Notifier<List<CustomWorkoutModel>> {
  int _nextId = 1;

  @override
  List<CustomWorkoutModel> build() => [
        CustomWorkoutModel(id: 'w0', name: 'Push Day', exerciseIds: ['e1', 'e2', 'e3']),
      ];

  void create(String name) {
    final workout = CustomWorkoutModel(id: 'w${_nextId++}', name: name, exerciseIds: []);
    state = [...state, workout];
  }

  void rename(String id, String newName) {
    state = [
      for (final w in state)
        if (w.id == id) w.copyWith(name: newName) else w,
    ];
  }

  void delete(String id) {
    state = state.where((w) => w.id != id).toList();
  }

  void toggleExercise(String workoutId, String exerciseId) {
    state = [
      for (final w in state)
        if (w.id == workoutId)
          w.copyWith(
            exerciseIds: w.exerciseIds.contains(exerciseId)
                ? (List<String>.from(w.exerciseIds)..remove(exerciseId))
                : (List<String>.from(w.exerciseIds)..add(exerciseId)),
          )
        else
          w,
    ];
  }
}

final customWorkoutsProvider = NotifierProvider<CustomWorkoutsNotifier, List<CustomWorkoutModel>>(
  CustomWorkoutsNotifier.new,
);
