import 'package:flutter/material.dart';

class ArmsScreen extends StatelessWidget {
  final List<String> exercises = [
    'Bicep Curls',
    'Tricep Dips',
    'Hammer Curls',
    'Tricep Pushdown',
    'Overhead Extension',
    'Concentration Curls',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Arms Exercises'),
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