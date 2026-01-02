import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartspend/features/auth/screens/login_screen.dart';
import 'package:smartspend/features/home/screens/home_screen.dart';
import '../screens/email_verification_screen.dart';
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Logged in
        if (snapshot.hasData) {
          final user = snapshot.data!;
  if (!user.emailVerified) {
    return const EmailVerificationScreen();
  }
  return const HomeScreen();
        }

        // Logged out
        return const LoginScreen();
      },
    );
  }
}
