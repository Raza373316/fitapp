import 'package:flutter/material.dart';

class ChestScreen extends StatelessWidget {
  final List<String> exercises = [
    'Push Ups',
    'Bench Press',
    'Incline Dumbbell Press',
    'Chest Dips',
    'Cable Fly',
    'Chest Press Machine',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chest Exercises'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: exercises.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) => ListTile(
          leading: Icon(Icons.fitness_center, color: Colors.teal),
          title: Text(
            exercises[index],
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
