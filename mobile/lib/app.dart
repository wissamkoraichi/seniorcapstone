import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile/features/auth/auth_test_screen.dart';
import 'package:mobile/features/ui/home_screen.dart';
import 'package:mobile/features/auth/login_screen.dart'; // change path to your login screen
import 'features/ui/home_screen.dart';
import 'features/auth/login_screen.dart';  

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // signed in
        if (snapshot.hasData) {
          return const HomeScreen(); // TEMP for testing auth only
        }


        // signed out
        return LoginScreen();
      },
    );
  }
}
