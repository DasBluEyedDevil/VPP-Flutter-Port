import 'package:flutter/material.dart';

class JustLiftScreen extends StatelessWidget {
  const JustLiftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Just Lift'),
      ),
      body: const Center(
        child: Text('Just Lift Screen'),
      ),
    );
  }
}
