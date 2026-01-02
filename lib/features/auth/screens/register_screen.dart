import 'package:flutter/material.dart';
import 'package:smartspend/features/auth/screens/login_screen.dart';
import 'package:provider/provider.dart';
import '../../auth/providers/auth_provider.dart';
class SmartSpendSignUp extends StatefulWidget {
  const SmartSpendSignUp({super.key});

  @override
  State<SmartSpendSignUp> createState() => _SmartSpendSignUpState();
}

class _SmartSpendSignUpState extends State<SmartSpendSignUp> {

final _emailController = TextEditingController();
final _passwordController = TextEditingController();
final _nameController = TextEditingController();
bool _obscurePassword = true;

 double _scale = 1.0;
 void _onTap()async{
  setState(() {
    _scale = 0.9;
  });
  await Future.delayed(const Duration(milliseconds: 120));
  setState(() {
    _scale = 1.0; 
  });
  Navigator.push(context, _slideFadeRoute(const LoginScreen()));
 }
 Route _slideFadeRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 350),
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, animation, __, child) {
      final slide = Tween(
        begin: const Offset(0, 0.15),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(parent: animation, curve: Curves.easeOut),
      );

      final fade = Tween(begin: 0.0, end: 1.0).animate(animation);

      return FadeTransition(
        opacity: fade,
        child: SlideTransition(
          position: slide,
          child: child,
        ),
      );
    },
  );
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE3F2FD), // blue-50
              Color(0xFFFCE4EC), // pink-50
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 30),

                /// App Icon
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF4A90FF),
                        Color(0xFF7B61FF),
                      ],
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "\$",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                /// Title
                const Text(
                  "Smart Spend",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A6CF7),
                  ),
                ),

                const SizedBox(height: 4),

                const Text(
                  "Create your account",
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 30),

                /// Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      /// Google Button
                      OutlinedButton.icon(
                        onPressed: () async {
                          // Handle Google Sign-In
                          final auth = context.read<AuthProvider>();
                              if (auth.isLoading) return;
                              final user = await auth.googleSignIn();
    
                              if (user != null) {
                                  // Navigate to home
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(auth.error ?? "Google Sign-In failed")),
                                );
                              }
                        },
                        icon: Image.asset(
                          "assets/images/icons8-google-48.png",
                          height: 20,
                        ),
                        label: const Text("Continue with Google"),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// OR Divider
                      Row(
                        children: const [
                          Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text("or"),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),

                      const SizedBox(height: 20),

                      /// Full Name
                      _inputLabel("Full Name"),
                      _inputField(
                        controller: _nameController,
                        hint: "Ged Sam",
                        icon: Icons.person_outline,
                      ),

                      const SizedBox(height: 16),

                      /// Email
                      _inputLabel("Email"),
                      _inputField(
                        // Email controller
                        controller: _emailController,
                        hint: "you@example.com",
                        icon: Icons.email_outlined,
                      ),

                      const SizedBox(height: 16),

                      /// Password
                      _inputLabel("Password"),
                      _inputField(
                        controller: _passwordController,
                        hint: "••••••••",
  icon: Icons.lock_outline,
  obscure: _obscurePassword,
  suffix: _obscurePassword
      ? Icons.visibility_outlined
      : Icons.visibility_off_outlined,
  onSuffixTap: () {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  },
                      ),

                      const SizedBox(height: 6),

                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Minimum 6 characters",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// Sign Up Button
                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF4A90FF),
                              Color(0xFF7B61FF),
                            ],
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            
                         final auth = context.read<AuthProvider>();

                         final user = await auth.signup(
                           _emailController.text.trim(),
                           _passwordController.text.trim(),
                         );

                         if (user != null) {
                           await auth.sendVerificationEmail();

                         ScaffoldMessenger.of(context).showSnackBar(
                           const SnackBar(
                             content: Text("Verification email sent. Check your inbox."),
                           ),
                         );
                           // Navigate to home
                         } else {
                           ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(content: Text(auth.error ?? "Signup failed")),
                           );
                         }
                       },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      /// Sign In
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account? "),
                          GestureDetector(
                            //add animation when it is tapped


                            onTap: _onTap,
                            child: AnimatedScale(scale: _scale, duration: const Duration(milliseconds: 120),
                            curve: Curves.easeInOut,
                             child:const Text(
                              "Sign In",
                              style: TextStyle(
                                color: Color(0xFF7B61FF),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Helpers
  static Widget _inputLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _inputField({
  required TextEditingController controller,
  required String hint,
  required IconData icon,
  IconData? suffix,
  VoidCallback? onSuffixTap,
  bool obscure = false,
}) {
  return TextField(
    controller: controller,
    obscureText: obscure,
    decoration: InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      suffixIcon: suffix != null
          ? IconButton(
              icon: Icon(suffix),
              onPressed: onSuffixTap,
            )
          : null,
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
    ),
  );
}

}
