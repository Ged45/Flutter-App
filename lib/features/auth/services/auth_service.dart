import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Email Sign Up
  Future<User?> signUpWithEmail(String email, String password) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return cred.user;
  }

  /// Email Login
  Future<User?> loginWithEmail(String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return cred.user;
  }

  /// Google Sign In
  Future<User?> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final cred = await _auth.signInWithCredential(credential);
    return cred.user;
  }

  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
  }

  Future<void> sendEmailVerification() async {
  final user = _auth.currentUser;
  if (user != null && !user.emailVerified) {
    await user.sendEmailVerification();
  }
}

Future<bool> reloadAndCheckEmailVerified() async {
  final user = _auth.currentUser;
  await user?.reload();
  return _auth.currentUser?.emailVerified ?? false;
}
Future<void> resetPassword(String email) async {
  await _auth.sendPasswordResetEmail(email: email);
}


}
