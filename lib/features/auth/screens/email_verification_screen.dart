import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthProvider>();

    return Scaffold(
      
      
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.mark_email_unread, size: 80),
              const SizedBox(height: 16),
              const Text(
                "Verify your email",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "We’ve sent a verification link to your email.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () async {
                  final verified = await auth.isEmailVerified();
                  if (verified) {
                    // AuthGate will redirect
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Email not verified yet"),
                      ),
                    );
                  }
                },
                child: const Text("I have verified"),
              ),

              TextButton(
                onPressed: auth.sendVerificationEmail,
                child: const Text("Resend email"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
