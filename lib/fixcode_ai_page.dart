import 'package:flutter/material.dart';

class FixCodeAIPage extends StatelessWidget {
  const FixCodeAIPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FixCode AI"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: const Center(
        child: Text(
          "FixCode AI coming soon...",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
