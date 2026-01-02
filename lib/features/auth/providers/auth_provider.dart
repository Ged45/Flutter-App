import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool isLoading = false;
  String? error;

  Future<User?> login(String email, String password) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      return await _authService.loginWithEmail(email, password);
    } catch (e) {
      error = e.toString();
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<User?> signup(String email, String password) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      return await _authService.signUpWithEmail(email, password);
    } catch (e) {
      error = e.toString();
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<User?> googleSignIn() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      return await _authService.signInWithGoogle();
    } catch (e) {
      error = e.toString();
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  Future<void> sendVerificationEmail() async {
  await _authService.sendEmailVerification();
}

Future<bool> isEmailVerified() async {
  return await _authService.reloadAndCheckEmailVerified();
}
Future<void> forgotPassword(String email) async {
  try {
    isLoading = true;
    notifyListeners();
    await _authService.resetPassword(email);
  } catch (e) {
    error = e.toString();
  } finally {
    isLoading = false;
    notifyListeners();
  }
}


}
