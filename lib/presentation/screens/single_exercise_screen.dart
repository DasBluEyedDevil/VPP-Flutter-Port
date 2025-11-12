import 'package:flutter/material.dart';

class SingleExerciseScreen extends StatelessWidget {
  const SingleExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Single Exercise'),
      ),
      body: const Center(
        child: Text('Single Exercise Screen'),
      ),
    );
  }
}
