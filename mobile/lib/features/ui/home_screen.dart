/* 
 * Name: Chloe Mellman
 * Date: February 1, 2026
 * Purpose: Home screen UI for the application.
 * 
*/

// lib/features/ui/home_screen.dart
import 'package:flutter/material.dart';
import 'settings_ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with title
      appBar: AppBar(title: const Text('Campus Watch')),
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        // Bottom navigation bar: home, contacts, map, and settings
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: const Color.fromARGB(255, 158, 155, 157),

        // the icons and the labels
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Contacts'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),

      // Main content of the home screen
      body: _buildPage(_selectedIndex),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return _buildHomePage();
      case 1:
        return _buildContactsPage();
      case 2:
        return _buildMapPage();
      case 3:
        return const SettingsScreen();
      default:
        return _buildHomePage();
    }
  }

  Widget _buildHomePage() {
    final actionButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 245, 169, 220),
      foregroundColor: Colors.white,
    );
    return SafeArea(
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
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showMaterialBanner(
                    MaterialBanner(
                      content: const Text(
                        'The SOS Button has been activated',
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                      backgroundColor: Colors.redAccent,
                      actions: [],
                    ),
                  );
                },
                onLongPressStart: (_) {
                  ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Text(
                      'SOS',
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactsPage() {
    return const Center(child: Text('Contacts Page - Coming Soon'));
  }

  Widget _buildMapPage() {
    return const Center(child: Text('Map Page - Coming Soon'));
  }
}
