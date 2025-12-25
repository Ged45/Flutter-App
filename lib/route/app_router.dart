import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smartspend/onboarding/screens/screen_3.dart';
import '../features/home/screens/home_screen.dart';
import 'package:smartspend/features/auth/screens/register_screen.dart';
import 'package:smartspend/features/auth/screens/login_screen.dart';
import '../features/expenses/screens/insights_screen.dart';
  void handleNav(BuildContext context, int index) {
    switch (index) {
      case 0:
        break;
      case 1:
         context.go('/scan');
        break;
      case 2:
        context.go('/insights');
        break;
      case 3:
        context.go('/bills');
        break;
      case 4:
        context.go('/goal');
        break;
    }
  }

final router = GoRouter(
  routes: [
    
    GoRoute(
      path: '/',
      redirect: (_, __) => '/onboarding',
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const SmartSpendSignUp(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(path: '/insights',
    builder: (context, state) => const InsightsScreen()),
  ],
);
