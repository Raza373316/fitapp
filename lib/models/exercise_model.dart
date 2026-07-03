class ExerciseModel {
  final String id;
  final String name;
  final String category;
  final String difficulty; // Beginner / Intermediate / Advanced
  final int calories;
  final String duration; // e.g. "12 min"
  final String equipment;
  final String muscle;
  final String benefits;
  final List<String> instructions;
  final int sets;
  final String reps;
  final String restTime;
  final String imageAsset; // placeholder path
  bool isFavorite;

  ExerciseModel({
    required this.id,
    required this.name,
    required this.category,
    required this.difficulty,
    required this.calories,
    required this.duration,
    required this.equipment,
    required this.muscle,
    required this.benefits,
    required this.instructions,
    required this.sets,
    required this.reps,
    required this.restTime,
    this.imageAsset = '',
    this.isFavorite = false,
  });
}
