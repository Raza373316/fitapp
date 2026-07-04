class CustomWorkoutModel {
  final String id;
  final String name;
  final List<String> exerciseIds;

  const CustomWorkoutModel({
    required this.id,
    required this.name,
    required this.exerciseIds,
  });

  CustomWorkoutModel copyWith({String? name, List<String>? exerciseIds}) {
    return CustomWorkoutModel(
      id: id,
      name: name ?? this.name,
      exerciseIds: exerciseIds ?? this.exerciseIds,
    );
  }
}
