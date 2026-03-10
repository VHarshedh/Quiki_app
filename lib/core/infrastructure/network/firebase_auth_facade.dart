import 'package:firebase_auth/firebase_auth.dart';

/// Thin wrapper around [FirebaseAuth] for testability and consistency.
class FirebaseAuthFacade {
  FirebaseAuthFacade({FirebaseAuth? auth})
      : _auth = auth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;

  /// Get the currently signed-in user (null if not signed in).
  User? get currentUser => _auth.currentUser;

  /// Stream of auth state changes.
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Sign in with email and password.
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  /// Create a new user with email and password.
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  /// Send a password reset email.
  Future<void> sendPasswordResetEmail({required String email}) {
    return _auth.sendPasswordResetEmail(email: email);
  }

  /// Sign out the current user.
  Future<void> signOut() {
    return _auth.signOut();
  }
}
