import 'package:flutter/material.dart';
import 'package:smartspend/features/auth/screens/login_screen.dart';
class SmartSpendSignUp extends StatefulWidget {
  const SmartSpendSignUp({super.key});

  @override
  State<SmartSpendSignUp> createState() => _SmartSpendSignUpState();
}

class _SmartSpendSignUpState extends State<SmartSpendSignUp> {

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
                        onPressed: () {},
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
                        hint: "Ged Sam",
                        icon: Icons.person_outline,
                      ),

                      const SizedBox(height: 16),

                      /// Email
                      _inputLabel("Email"),
                      _inputField(
                        hint: "you@example.com",
                        icon: Icons.email_outlined,
                      ),

                      const SizedBox(height: 16),

                      /// Password
                      _inputLabel("Password"),
                      _inputField(
                        hint: "••••••••",
                        icon: Icons.lock_outline,
                        suffix: Icons.visibility_off_outlined,
                        obscure: true,
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
                          onPressed: () {},
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

  static Widget _inputField({
    required String hint,
    required IconData icon,
    IconData? suffix,
    bool obscure = false,
  }) {
    return TextField(
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        suffixIcon: suffix != null ? Icon(suffix) : null,
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
