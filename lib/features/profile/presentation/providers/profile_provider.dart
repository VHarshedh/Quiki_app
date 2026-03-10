import 'package:flutter/foundation.dart';
import '../../infrastructure/repos/profile_repo.dart';

/// Profile state provider using ChangeNotifier.
class ProfileProvider extends ChangeNotifier {
  ProfileProvider({required this.profileRepo});

  final ProfileRepo profileRepo;

  Map<String, dynamic>? _profileData;
  bool _isLoading = false;
  String? _errorMessage;

  Map<String, dynamic>? get profileData => _profileData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  String get name => _profileData?['name'] ?? '';
  String get email => _profileData?['email'] ?? '';
  String get phone => _profileData?['phone'] ?? '';
  String get image => _profileData?['image'] ?? '';

  /// Load profile from Firestore.
  Future<void> loadProfile(String uid) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _profileData = await profileRepo.getProfile(uid);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Update profile fields.
  Future<bool> updateProfile(String uid, Map<String, dynamic> data) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await profileRepo.updateProfile(uid, data);
      // Update local cache
      _profileData = {...?_profileData, ...data};
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
