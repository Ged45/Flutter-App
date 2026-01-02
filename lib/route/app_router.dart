import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartspend/features/auth/screens/profile_screen.dart';
import 'package:smartspend/onboarding/screens/screen_3.dart';
import 'package:smartspend/features/auth/screens/login_screen.dart';
import 'package:smartspend/features/auth/screens/register_screen.dart';
import 'package:smartspend/features/auth/screens/email_verification_screen.dart';
import 'package:smartspend/features/home/screens/home_screen.dart';
import 'package:smartspend/features/expenses/screens/insights_screen.dart';
import 'package:smartspend/features/barcode/screens/barcode_scanner_screen.dart';
import 'package:smartspend/features/bills/screens/bills_screen.dart';
import 'package:smartspend/features/goals/screens/goals_screen.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

void handleNav(BuildContext context, int index) {
  switch (index) {
    case 0:
      context.go('/home');
      break;
    case 1:
      context.go('/scan');
      break;
    case 2:
      context.go('/insights');
      break;
    case 3:
      context.go('/bill');
      break;
    case 4:
      context.go('/goal');
      break;
    case 5:
      context.go('/profile');
      break;
 
  }
}

final router = GoRouter(
  refreshListenable:
      GoRouterRefreshStream(FirebaseAuth.instance.authStateChanges()),

  redirect: (context, state) {
    final user = FirebaseAuth.instance.currentUser;
    final loggedIn = user != null;
    final verified = user?.emailVerified ?? false;

    final location = state.matchedLocation;

    final isAuthRoute =
        location == '/login' || location == '/register';

    if (!loggedIn) {
      return isAuthRoute ? null : '/login';
    }

    if (loggedIn && !verified) {
      return location == '/verify' ? null : '/verify';
    }

    if (loggedIn && verified && isAuthRoute) {
      return '/home';
    }

    return null;
  },

  routes: [
    GoRoute(
      path: '/',
      redirect: (_, __) => '/onboarding',
    ),
    GoRoute(
      path: '/onboarding',
      builder: (_, __) => const OnboardingPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (_, __) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (_, __) => const SmartSpendSignUp(),
    ),
    GoRoute(
      path: '/verify',
      builder: (_, __) => const EmailVerificationScreen(),
    ),
    GoRoute(path:   '/profile',
      builder: (_, __) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (_, __) => const HomeScreen(),
    ),
    
    GoRoute(
      path: '/insights',
      builder: (_, __) => const InsightsScreen(),
    ),
    GoRoute(
      path: '/scan',
      builder: (_, __) => const ScanScreen(),
    ),
    GoRoute(
      path: '/bill',
      builder: (_, __) => const BillsScreen(),
    ),
    GoRoute(
      path: '/goal',
      builder: (_, __) => const GoalScreen(),
    ),
  ],
);
