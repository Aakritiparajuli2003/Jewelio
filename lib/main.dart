import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase/firebase_options.dart';
import 'package:jewelio/screens/onboarding_screen.dart';
import 'package:jewelio/screens/home_screen.dart';
import 'package:jewelio/screens/cart_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Using FutureBuilder to ensure Firebase is initialized before loading the app
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Jewelio',
            home: RootScreen(), // decides between onboarding or home
          );
        }
        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text(
                  'Firebase Initialization Error:\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }
        // Loading state
        return const MaterialApp(
          home: Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}

/// RootScreen decides which screen to show: Onboarding or Home
class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  bool _isLoading = true;
  bool _seenOnboarding = false; // this will be loaded from SharedPreferences later

  @override
  void initState() {
    super.initState();
    _checkOnboarding();
  }

  Future<void> _checkOnboarding() async {
    // Simulate async loading, e.g., from SharedPreferences
    await Future.delayed(const Duration(seconds: 1));

  

    setState(() {
      _isLoading = false;
      _seenOnboarding = false; // set true if onboarding already done
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return _seenOnboarding
        ? const HomeScreen()       // Show HomeScreen if onboarding is done
        : const OnboardingScreen(); // Otherwise show Onboarding
  }
}

