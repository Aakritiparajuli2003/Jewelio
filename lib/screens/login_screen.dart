import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jewelio/screens/home_screen.dart';
import 'package:jewelio/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoading = false;

  // ------------------ EMAIL/PASSWORD LOGIN ------------------
  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login failed: $e')));
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  // ------------------ GOOGLE SIGN-IN ------------------
  Future<void> signInWithGoogle() async {
    setState(() => isLoading = true);

    try {
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn().signIn();

      if (googleUser == null) {
        setState(() => isLoading = false);
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Google Sign-In failed: $e')));
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  // ------------------ RESET PASSWORD ------------------
  Future<void> resetPassword() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      await _auth.sendPasswordResetEmail(email: email);
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Reset failed: $e')));
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  // ------------------ UI ------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F5EB),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(120),
                bottomRight: Radius.circular(120),
              ),
              child: SizedBox(
                height: 350,
                width: double.infinity,
                child: Image.asset(
                  "assets/signup.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              "Welcome Back!",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              "Enter your email and password",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),

            const SizedBox(height: 35),

            // EMAIL
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: UnderlineInputBorder(),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // PASSWORD
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: UnderlineInputBorder(),
                ),
              ),
            ),

            const SizedBox(height: 10),

            TextButton(
              onPressed: resetPassword,
              child: const Text("Forgot Password?"),
            ),

            const SizedBox(height: 25),

            // LOGIN BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ElevatedButton(
                onPressed: isLoading ? null : login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffD84F4F),
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Log In",
                        style: TextStyle(fontSize: 20),
                      ),
              ),
            ),

            const SizedBox(height: 30),

            // OR
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(width: 100, child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text("or"),
                ),
                SizedBox(width: 100, child: Divider()),
              ],
            ),

            const SizedBox(height: 30),

            // GOOGLE SIGN-IN
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                height: 56,
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: isLoading ? null : signInWithGoogle,
                  icon: Image.asset(
                    'assets/google1.png',
                    height: 22,
                  ),
                  label: const Text(
                    'Sign in with Google',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // SIGN UP
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SignupScreen()),
                );
              },
              child: const Text(
                "Don’t have an account? Sign up",
                style: TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
