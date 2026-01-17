import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jewelio/screens/signup_screen.dart';
import 'package:jewelio/screens/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool isLoading = false;

  Future<void> signInWithGoogle() async {
    setState(() => isLoading = true);
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // User cancelled the sign-in
        if (mounted) setState(() => isLoading = false);
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with Google credential
      await FirebaseAuth.instance.signInWithCredential(credential);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Google Sign-in Successful')),
      );

      // Navigate to LoginScreen/HomeScreen
      Future.delayed(const Duration(seconds: 1), () {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Google Sign-in Failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9F3),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image Section
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(28),
                ),
                child: Image.asset(
                  'assets/onboarding.jpg',
                  height: MediaQuery.of(context).size.height * 0.48,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 16),

              // Dots Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _dot(isActive: true),
                  _dot(),
                  _dot(),
                ],
              ),

              const SizedBox(height: 30),

              // Title
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 28),
                child: Text(
                  'Jewelry That Sparkles,\nMoments That Shine',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Sign up with Email
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SignupScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE05252),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: const Text(
                      'Sign up with email',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Google Sign-in Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: OutlinedButton.icon(
                    onPressed: isLoading ? null : signInWithGoogle,
                    icon: isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Image.asset(
                            'assets/google1.png',
                            height: 22,
                          ),
                    label: Text(
                      isLoading ? 'Signing in...' : 'Sign up with Google',
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Sign in link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account? '),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Color(0xFFE05252),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Terms & Privacy
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                    children: [
                      TextSpan(text: 'By signing up, you agree to our '),
                      TextSpan(
                        text: 'Terms and Condition',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: '.\nLearn how we use your data in our '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dot({bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.grey.shade400,
        shape: BoxShape.circle,
      ),
    );
  }
}
