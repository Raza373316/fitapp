import 'package:flutter/material.dart';

class BackScreen extends StatelessWidget {
  final List<String> exercises = [
    'Pull Ups',
    'Deadlifts',
    'Bent Over Rows',
    'Lat Pulldown',
    'Seated Cable Row',
    'T-Bar Row',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Back Exercises'),
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