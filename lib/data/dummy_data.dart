
import 'package:flutter/material.dart';

import 'models/category_model.dart';
import 'models/exercise_model.dart';

class DummyData {
  DummyData._();

  static const List<CategoryModel> homeCategories = [
    CategoryModel(name: 'Chest', icon: Icons.fitness_center, exerciseCount: 12),
    CategoryModel(name: 'Back', icon: Icons.rowing, exerciseCount: 10),
    CategoryModel(name: 'Arms', icon: Icons.sports_gymnastics, exerciseCount: 14),
    CategoryModel(name: 'Legs', icon: Icons.directions_walk, exerciseCount: 11),
    CategoryModel(name: 'Abs', icon: Icons.self_improvement, exerciseCount: 9),
    CategoryModel(name: 'Cardio', icon: Icons.favorite_border, exerciseCount: 8),
    CategoryModel(name: 'Yoga', icon: Icons.spa, exerciseCount: 7),
    CategoryModel(name: 'HIIT', icon: Icons.bolt, exerciseCount: 6),
  ];

  static const List<CategoryModel> allCategories = [
    CategoryModel(name: 'Chest', icon: Icons.fitness_center, exerciseCount: 12),
    CategoryModel(name: 'Back', icon: Icons.rowing, exerciseCount: 10),
    CategoryModel(name: 'Shoulders', icon: Icons.accessibility_new, exerciseCount: 8),
    CategoryModel(name: 'Arms', icon: Icons.sports_gymnastics, exerciseCount: 14),
    CategoryModel(name: 'Legs', icon: Icons.directions_walk, exerciseCount: 11),
    CategoryModel(name: 'Abs', icon: Icons.self_improvement, exerciseCount: 9),
    CategoryModel(name: 'Cardio', icon: Icons.favorite_border, exerciseCount: 8),
    CategoryModel(name: 'Yoga', icon: Icons.spa, exerciseCount: 7),
    CategoryModel(name: 'HIIT', icon: Icons.bolt, exerciseCount: 6),
    CategoryModel(name: 'Stretching', icon: Icons.accessibility, exerciseCount: 5),
    CategoryModel(name: 'Full Body', icon: Icons.emoji_events_outlined, exerciseCount: 13),
  ];

  static final List<ExerciseModel> exercises = [
    ExerciseModel(
      id: 'e1',
      name: 'Push Up',
      category: 'Chest',
      difficulty: 'Beginner',
      calories: 80,
      duration: '10 min',
      equipment: 'Bodyweight',
      muscle: 'Chest, Triceps, Shoulders',
      benefits:
          'Builds upper body pressing strength, engages the core for stability, and needs no equipment.',
      instructions: [
        'Start in a plank with hands under shoulders.',
        'Lower your chest toward the floor, elbows at ~45°.',
        'Push back up to full arm extension.',
        'Keep your core tight throughout.',
      ],
      sets: 3,
      reps: '12-15',
      restTime: '45 sec',
    ),
    ExerciseModel(
      id: 'e2',
      name: 'Bench Press',
      category: 'Chest',
      difficulty: 'Intermediate',
      calories: 110,
      duration: '15 min',
      equipment: 'Barbell, Bench',
      muscle: 'Chest, Triceps, Shoulders',
      benefits: 'The core barbell movement for building raw chest strength and mass.',
      instructions: [
        'Lie on the bench, feet flat on the floor.',
        'Grip the bar slightly wider than shoulder-width.',
        'Lower the bar to mid-chest with control.',
        'Press up until arms are fully extended.',
      ],
      sets: 4,
      reps: '8-10',
      restTime: '90 sec',
    ),
    ExerciseModel(
      id: 'e3',
      name: 'Incline Press',
      category: 'Chest',
      difficulty: 'Intermediate',
      calories: 100,
      duration: '15 min',
      equipment: 'Dumbbells, Incline Bench',
      muscle: 'Upper Chest, Shoulders',
      benefits: 'Targets the upper chest fibers that flat pressing tends to miss.',
      instructions: [
        'Set the bench to a 30-45° incline.',
        'Press dumbbells up until arms extend.',
        'Lower slowly to chest level.',
        'Repeat with control on every rep.',
      ],
      sets: 3,
      reps: '10-12',
      restTime: '75 sec',
    ),
    ExerciseModel(
      id: 'e4',
      name: 'Decline Push Up',
      category: 'Chest',
      difficulty: 'Intermediate',
      calories: 90,
      duration: '10 min',
      equipment: 'Bodyweight, Bench',
      muscle: 'Upper Chest, Shoulders',
      benefits: 'A harder push-up variation that shifts more load onto the upper chest.',
      instructions: [
        'Place feet on a raised bench, hands on the floor.',
        'Lower your chest toward the ground.',
        'Push back up to full extension.',
        'Keep hips in line with shoulders.',
      ],
      sets: 3,
      reps: '10-12',
      restTime: '60 sec',
    ),
    ExerciseModel(
      id: 'e5',
      name: 'Dumbbell Fly',
      category: 'Chest',
      difficulty: 'Beginner',
      calories: 70,
      duration: '10 min',
      equipment: 'Dumbbells, Bench',
      muscle: 'Chest',
      benefits: 'Isolates the chest through a long stretch-to-squeeze range of motion.',
      instructions: [
        'Lie on a bench holding a dumbbell in each hand above your chest.',
        'Lower the weights out to the sides with a slight elbow bend.',
        'Squeeze your chest to bring the dumbbells back up.',
        'Avoid locking out the elbows.',
      ],
      sets: 3,
      reps: '12-15',
      restTime: '60 sec',
    ),
    ExerciseModel(
      id: 'e6',
      name: 'Cable Fly',
      category: 'Chest',
      difficulty: 'Intermediate',
      calories: 75,
      duration: '10 min',
      equipment: 'Cable Machine',
      muscle: 'Chest',
      benefits: 'Keeps constant tension on the chest through the full range of motion.',
      instructions: [
        'Set both pulleys to chest height.',
        'Step forward and bring handles together in front of your chest.',
        'Control the return to a full stretch.',
        'Keep a slight bend in the elbows.',
      ],
      sets: 3,
      reps: '12-15',
      restTime: '60 sec',
    ),
  ];

  static List<ExerciseModel> exercisesByCategory(String category) {
    return exercises.where((e) => e.category == category).toList();
  }

  static List<ExerciseModel> get popularExercises => exercises.take(4).toList();

  static const List<String> quotes = [
    '"The only bad workout is the one that didn\'t happen."',
    '"Push yourself, because no one else is going to do it for you."',
    '"Discipline is choosing between what you want now and what you want most."',
  ];
}
