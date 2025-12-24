import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import './screen_2.dart';
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with TickerProviderStateMixin {
  final PageController _controller = PageController();
  int _index = 0;

  late final AnimationController _floatController;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _floatController.dispose();
    super.dispose();
  }

  void _next() {
    if (_index == 2) {
      context.go('/login');
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF1F6FF),
              Color(0xFFFFEEF4),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Skip
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () => context.go('/login'),
                  child: const Text('Skip'),
                ),
              ),

              // Pages
              Expanded(
                child: PageView(
                  controller: _controller,
                  onPageChanged: (i) => setState(() => _index = i),
                  children: [
                    OnboardContent(
                      floatController: _floatController,
                      badge: 'One-tap expense logging',
                      title: 'Track Expenses Instantly',
                      description:
                          'Add expenses in seconds with our quick-add feature, '
                          'categorize automatically and never miss a transaction.',
                      centerIcon: Icons.flash_on,
                      sideIcons: const [
                        FloatingIcon(Icons.attach_money, Colors.green, Offset(-90, -10)),
                        FloatingIcon(Icons.attach_money, Colors.blue, Offset(-40, 40)),
                        FloatingIcon(Icons.flash_on, Colors.amber, Offset(90, 40)),
                      ],
                    ),
                    OnboardContent(
                      floatController: _floatController,
                      badge: 'Scan & save with barcode scanning',
                      title: 'Smart Price Comparison',
                      description:
                          'Scan product barcodes to compare prices across nearby stores.\n'
                          'Find the best deals and save money.',
                      centerIcon: Icons.qr_code,
                      sideIcons: const [
                        FloatingIcon(Icons.attach_money, Colors.green, Offset(-90, 20)),
                        FloatingIcon(Icons.qr_code_scanner, Colors.deepPurple, Offset(90, 10)),
                        FloatingIcon(Icons.radio_button_checked, Colors.deepOrange, Offset(40, 60)),
                      ],
                    ),
                    InsightsGoalsScreen(
                               onFinish: () => context.go('/login'),
                                ),

                  ],
                ),
              ),

              // Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _index == i ? 20 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _index == i
                          ? const Color(0xFF4A7DFF)
                          : Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Next Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  height: 56,
                  width: double.infinity,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4A7DFF), Color(0xFF7B4DFF)],
                      ),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: ElevatedButton(
                      onPressed: _next,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(_index == 2 ? 'Get Started' : 'Next', style: const TextStyle(fontSize: 16, color: Colors.white)),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward , color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),
              Text('${_index + 1} of 3'),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class FloatingIcon {
  final IconData icon;
  final Color color;
  final Offset offset;
  const FloatingIcon(this.icon, this.color, this.offset);
}

class OnboardContent extends StatelessWidget {
  final String badge;
  final String title;
  final String description;
  final IconData centerIcon;
  final List<FloatingIcon> sideIcons;
  final AnimationController floatController;

  const OnboardContent({
    super.key,
    required this.badge,
    required this.title,
    required this.description,
    required this.centerIcon,
    required this.sideIcons,
    required this.floatController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        SizedBox(
          height: 180,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ...sideIcons.map(
                (i) => AnimatedBuilder(
                  animation: floatController,
                  builder: (_, __) => Transform.translate(
                    offset: Offset(
                      i.offset.dx,
                      i.offset.dy + (floatController.value * 10),
                    ),
                    child: _iconCard(i.icon, i.color),
                  ),
                ),
              ),
              ScaleTransition(
                scale: Tween(begin: 0.95, end: 1.05).animate(
                  CurvedAnimation(
                    parent: floatController,
                    curve: Curves.easeInOut,
                  ),
                ),
                child: _centerCircle(centerIcon),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _badge(badge),
        const SizedBox(height: 20),
        Text(title,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Widget _centerCircle(IconData icon) => Container(
        width: 96,
        height: 96,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient:
              LinearGradient(colors: [Color(0xFF4A7DFF), Color(0xFF7B4DFF)]),
        ),
        child: Icon(icon, size: 42, color: Colors.white),
      );

  Widget _iconCard(IconData icon, Color color) => Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(blurRadius: 10, color: Colors.black12)
          ],
        ),
        child: Icon(icon, color: color),
      );

  Widget _badge(String text) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(text, style: const TextStyle(fontSize: 13)),
      );
}
