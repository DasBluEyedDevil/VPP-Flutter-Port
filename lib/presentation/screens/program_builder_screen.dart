import 'package:flutter/material.dart';

class ProgramBuilderScreen extends StatelessWidget {
  final String programId;

  const ProgramBuilderScreen({
    super.key,
    required this.programId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Program Builder'),
      ),
      body: Center(
        child: Text('Program Builder Screen\nProgram ID: $programId'),
      ),
    );
  }
}
