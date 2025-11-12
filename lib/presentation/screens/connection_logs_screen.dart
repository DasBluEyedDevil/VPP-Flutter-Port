import 'package:flutter/material.dart';

class ConnectionLogsScreen extends StatelessWidget {
  const ConnectionLogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connection Logs'),
      ),
      body: const Center(
        child: Text('Connection Logs Screen'),
      ),
    );
  }
}
