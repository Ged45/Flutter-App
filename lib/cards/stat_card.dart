import 'package:flutter/material.dart';
import './card_decoration.dart';
import '../animation/couter_widget.dart';
class StatCard extends StatelessWidget {
  final String title, subtitle;
  final double value;
  final IconData icon;
  final Color iconBg;

  const StatCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.iconBg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.blue),
          ),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(color: Colors.black54)),
          const SizedBox(height: 6),
          AnimatedNumber(value: value, suffix: 'Birr'),

          const SizedBox(height: 6),
          Text(subtitle,
              style: const TextStyle(color: Colors.green, fontSize: 12)),
        ],
      ),
    );
  }
}
