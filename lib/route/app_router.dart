import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smartspend/onboarding/screens/screen_3.dart';
import '../features/home/screens/home_screen.dart';
import 'package:smartspend/features/auth/screens/register_screen.dart';
import 'package:smartspend/features/auth/screens/login_screen.dart';
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
    
  ],
);
