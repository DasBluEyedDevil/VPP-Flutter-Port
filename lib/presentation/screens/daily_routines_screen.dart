import 'package:flutter/material.dart';

class DailyRoutinesScreen extends StatelessWidget {
  const DailyRoutinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Routines'),
      ),
      body: const Center(
        child: Text('Daily Routines Screen'),
      ),
    );
  }
}
