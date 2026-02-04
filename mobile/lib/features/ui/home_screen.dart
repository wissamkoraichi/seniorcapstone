/* 
 * Name: Chloe Mellman
 * Date: February 1, 2026
 * Purpose: Home screen UI for the application.
 * 
*/

// lib/features/ui/home_screen.dart
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Campus Safety')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: () {}, child: const Text('SOS')),
          ElevatedButton(onPressed: () {}, child: const Text('Open Map')),
        ],
      ),
    );
  }
}
