import 'package:flutter/foundation.dart';
import '../../domain/user.dart';
import '../../infrastructure/repos/auth_repo.dart';

/// Auth state provider using ChangeNotifier (Quiki's Provider-based equivalent
/// of Deliverzler's Riverpod auth providers).
class AuthProvider extends ChangeNotifier {
  AuthProvider({required this.authRepo});

  final AuthRepo authRepo;

  AppUser _user = AppUser.guest;
  bool _isLoading = false;
  String? _errorMessage;

  AppUser get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => !_user.isGuest;

  /// Sign in with email and password.
  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _errorMessage = null;
    try {
      _user = await authRepo.signInWithEmail(email: email, password: password);
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = _parseError(e);
      _setLoading(false);
      return false;
    }
  }

  /// Create a new account.
  Future<bool> signUp({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _errorMessage = null;
    try {
      _user = await authRepo.signUpWithEmail(email: email, password: password);
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = _parseError(e);
      _setLoading(false);
      return false;
    }
  }

  /// Try restoring the user session from Firebase Auth.
  Future<void> tryAutoLogin() async {
    final uid = authRepo.getCurrentUserUid();
    if (uid != null) {
      try {
        _user = await authRepo.getUserData(uid);
      } catch (_) {
        _user = AppUser.guest;
      }
    }
    notifyListeners();
  }

  /// Send password reset email.
  Future<bool> sendPasswordReset(String email) async {
    _setLoading(true);
    _errorMessage = null;
    try {
      await authRepo.sendPasswordReset(email);
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = _parseError(e);
      _setLoading(false);
      return false;
    }
  }

  /// Sign out.
  Future<void> signOut() async {
    await authRepo.signOut();
    _user = AppUser.guest;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String _parseError(dynamic e) {
    if (e is Exception) {
      return e.toString().replaceAll('Exception: ', '');
    }
    return 'An unexpected error occurred.';
  }
}
