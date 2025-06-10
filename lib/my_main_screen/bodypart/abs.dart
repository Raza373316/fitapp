import 'package:flutter/material.dart';

class AbsScreen extends StatelessWidget {
  final List<String> exercises = [
    'Crunches',
    'Plank',
    'Leg Raises',
    'Russian Twists',
    'Mountain Climbers',
    'Bicycle Crunches',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Abs Exercises'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: exercises.length,
        itemBuilder: (context, index) => Card(
          child: ListTile(
            leading: Icon(Icons.fitness_center, color: Colors.teal),
            title: Text(exercises[index]),
          ),
        ),
      ),
    );
  }
}
