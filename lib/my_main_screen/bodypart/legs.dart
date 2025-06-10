import 'package:flutter/material.dart';

class LegsScreen extends StatelessWidget {
  final List<String> exercises = [
    'Squats',
    'Lunges',
    'Leg Press',
    'Calf Raises',
    'Deadlifts',
    'Leg Extensions',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Legs Exercises'),
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
