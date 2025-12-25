import 'package:flutter/material.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'Scan'),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Insights'),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications), label: 'Bills'),
        BottomNavigationBarItem(icon: Icon(Icons.flag), label: 'Goal'),
      ],
    );
  }
}
