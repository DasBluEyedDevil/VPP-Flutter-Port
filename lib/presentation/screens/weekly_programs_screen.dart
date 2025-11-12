import 'package:flutter/material.dart';

class WeeklyProgramsScreen extends StatelessWidget {
  const WeeklyProgramsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly Programs'),
      ),
      body: const Center(
        child: Text('Weekly Programs Screen'),
      ),
    );
  }
}
