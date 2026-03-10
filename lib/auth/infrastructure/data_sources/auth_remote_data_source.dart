import '../../../core/infrastructure/error/app_exception.dart';
import '../../../core/infrastructure/network/firebase_auth_facade.dart';
import '../../../core/infrastructure/network/firebase_firestore_facade.dart';
import '../dtos/user_dto.dart';

/// Handles all remote Firebase calls for auth-related operations.
class AuthRemoteDataSource {
  AuthRemoteDataSource({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  final FirebaseAuthFacade firebaseAuth;
  final FirebaseFirestoreFacade firebaseFirestore;

  static const String usersCollectionPath = 'users';
  static String userDocPath(String uid) => '$usersCollectionPath/$uid';

  /// Sign in with email and returns [UserDto] from the credential.
  Future<UserDto> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserDto.fromUserCredential(userCredential.user!);
  }

  /// Create a new account with email and returns [UserDto].
  Future<UserDto> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserDto.fromUserCredential(userCredential.user!);
  }

  /// Get the current auth user's UID.
  String? getCurrentUserUid() {
    return firebaseAuth.currentUser?.uid;
  }

  /// Fetch user profile data from Firestore.
  Future<UserDto> getUserData(String uid) async {
    final response = await firebaseFirestore.getData(path: userDocPath(uid));
    final data = response.data();
    if (data != null) {
      return UserDto.fromJson(data);
    } else {
      throw const ServerException(
        type: ServerExceptionType.notFound,
        message: 'User data not found.',
      );
    }
  }

  /// Save user profile data to Firestore.
  Future<void> setUserData(UserDto userDto) async {
    return firebaseFirestore.setData(
      path: userDocPath(userDto.id),
      data: userDto.toJson(),
      merge: true,
    );
  }

  /// Send password reset email.
  Future<void> sendPasswordReset(String email) async {
    return firebaseAuth.sendPasswordResetEmail(email: email);
  }

  /// Sign out.
  Future<void> signOut() async {
    return firebaseAuth.signOut();
  }
}
