import 'package:flutter/material.dart';
import '../providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ForgotPasswordSheet extends StatefulWidget {
  const ForgotPasswordSheet();

  @override
  State<ForgotPasswordSheet> createState() => _ForgotPasswordSheetState();
}

class _ForgotPasswordSheetState extends State<ForgotPasswordSheet> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Reset password",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              hintText: "you@example.com",
            ),
          ),
          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: auth.isLoading
                ? null
                : () async {
                    await auth.forgotPassword(
                      _emailController.text.trim(),
                    );

                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Password reset email sent"),
                      ),
                    );
                  },
            child: auth.isLoading
                ? const CircularProgressIndicator()
                : const Text("Send reset link"),
          ),
        ],
      ),
    );
  }
}
