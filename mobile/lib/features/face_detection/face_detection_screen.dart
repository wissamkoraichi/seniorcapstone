import 'package:flutter/material.dart';

class FaceDetectionScreen extends StatelessWidget {
  const FaceDetectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Face Detection'),
      ),
      body: const Center(
        child: Text(
          'Face detection coming soon 👀',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
