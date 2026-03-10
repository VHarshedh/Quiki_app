import '../../../../core/infrastructure/network/firebase_firestore_facade.dart';

/// Profile repository for reading/writing user profile data to Firestore.
class ProfileRepo {
  ProfileRepo({required this.firebaseFirestore});

  final FirebaseFirestoreFacade firebaseFirestore;

  String _userDocPath(String uid) => 'users/$uid';

  /// Get user profile from Firestore.
  Future<Map<String, dynamic>?> getProfile(String uid) async {
    final doc = await firebaseFirestore.getData(path: _userDocPath(uid));
    return doc.data();
  }

  /// Update user profile.
  Future<void> updateProfile(String uid, Map<String, dynamic> data) async {
    await firebaseFirestore.setData(
      path: _userDocPath(uid),
      data: data,
      merge: true,
    );
  }
}
