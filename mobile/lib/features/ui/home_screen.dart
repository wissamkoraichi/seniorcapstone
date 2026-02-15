/* 
 * Name: Chloe Mellman
 * Date: February 1, 2026
 * Purpose: Home screen UI for the application.
 * 
*/

// lib/features/ui/home_screen.dart
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  // super key for super class for stateless widget
  const HomeScreen({super.key});

  // Widget build method to create the homescreen UI
  @override
  Widget build(BuildContext context) {
    // Basic layout for home screen with app bar, bottom navigation bar, and main content
    final actionButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 245, 169, 220),
      foregroundColor: Colors.white,
    );
    return Scaffold(
      // App bar with title
      appBar: AppBar(title: const Text('Campus Watch')),
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: BottomNavigationBar(
        // Bottom navigation bar: home, friends, map, and settings
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: const Color.fromARGB(255, 158, 155, 157),

        // the icons and the labels
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Friends'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),

      // Main content of the home screen
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'Campus Watch',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Row for buttons (layout)
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  ElevatedButton(
                    // callback function for quick call campus safety button
                    onPressed: () {},
                    style: actionButtonStyle,
                    child: const Text('Call Campus Safety'),
                  ),

                  // FOR FUTURE IMPLEMENTATION: to share location
                  ElevatedButton(
                    // callback function for share location button
                    onPressed: () {},
                    style: actionButtonStyle,
                    child: const Text('Share Location'),
                  ),

                  // FOR FUTURE IMPLEMENTATION: to open the map screen
                  ElevatedButton(
                    onPressed: () {},
                    style: actionButtonStyle,
                    child: const Text('Campus Resources'),
                  ),
                ],
              ),

              // Spacer to push the SOS button to the bottom of the screen
              const Spacer(),
              SizedBox(
                height: 100,
                width: double.infinity,
                child: ElevatedButton(
                  // callback function for the SOS button
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),

                  // The SOS button styling
                  child: const Text(
                    'SOS',
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
