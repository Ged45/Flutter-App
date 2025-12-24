import 'package:flutter/material.dart';

class InsightsGoalsScreen extends StatefulWidget {
  final VoidCallback onFinish;

  const InsightsGoalsScreen({
    super.key,
    required this.onFinish,
  });

  @override
  State<InsightsGoalsScreen> createState() => _InsightsGoalsScreenState();
}

class _InsightsGoalsScreenState extends State<InsightsGoalsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _floatAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _floatAnim = Tween<double>(begin: -8, end: 8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFEFF6FF),
            Color(0xFFFDECEF),
          ],
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            /// Skip
            Positioned(
              top: 8,
              right: 16,
              child: TextButton(
                onPressed: widget.onFinish,
                child: const Text(
                  "Skip",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ),

            /// Floating icons
            _floatingIcon(
              top: size.height * 0.18,
              left: size.width * 0.25,
              offset: 1.0,
              child: _iconCard(
                icon: Icons.attach_money,
                color: Colors.green,
              ),
            ),
            _floatingIcon(
              top: size.height * 0.22,
              left: size.width * 0.18,
              offset: 1.5,
              child: _iconCard(
                icon: Icons.notifications_none,
                color: Colors.deepOrange,
              ),
            ),
            _floatingIcon(
              top: size.height * 0.19,
              right: size.width * 0.22,
              offset: 0.8,
              child: _iconCard(
                icon: Icons.radio_button_checked,
                color: Colors.blue,
              ),
            ),

            /// Center floating icon
            _floatingIcon(
              top: size.height * 0.17,
              left: size.width * 0.4,
              offset: 1.2,
              child: Container(
                width: 90,
                height: 90,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF1EC100),
                ),
                child: const Icon(
                  Icons.trending_up,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),

            /// Content
            Positioned(
              top: size.height * 0.45,
              left: 24,
              right: 24,
              child: Column(
                children: const [
                  _Badge(),
                  SizedBox(height: 20),
                  Text(
                    "Insights & Goals",
                    style:
                        TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Get detailed spending insights, set financial goals, and receive bill reminders. Take control of your finance",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Floating wrapper
  Widget _floatingIcon({
    double? top,
    double? left,
    double? right,
    required double offset,
    required Widget child,
  }) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Positioned(
          top: top! + (_floatAnim.value * offset),
          left: left,
          right: right,
          child: child,
        );
      },
    );
  }

  static Widget _iconCard({
    required IconData icon,
    required Color color,
  }) =>
      Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black12,
            )
          ],
        ),
        child: Icon(icon, color: color),
      );
}

/// Badge
class _Badge extends StatelessWidget {
  const _Badge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        "Stay on track with smart analytics",
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
      ),
    );
  }
}
