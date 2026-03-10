import '../../domain/user.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../dtos/user_dto.dart';

/// Auth repository that orchestrates data sources and
/// maps DTOs to domain entities.
class AuthRepo {
  AuthRepo({required this.remoteDataSource});

  final AuthRemoteDataSource remoteDataSource;

  /// Sign in with email/password and return the domain [AppUser].
  Future<AppUser> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final userDto = await remoteDataSource.signInWithEmail(
      email: email,
      password: password,
    );
    // Save user data to Firestore if it's a first-time login
    await remoteDataSource.setUserData(userDto);
    return userDto.toDomain();
  }

  /// Create a new account and return the domain [AppUser].
  Future<AppUser> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    final userDto = await remoteDataSource.signUpWithEmail(
      email: email,
      password: password,
    );
    // Save new user profile to Firestore
    await remoteDataSource.setUserData(userDto);
    return userDto.toDomain();
  }

  /// Get the current auth user's UID.
  String? getCurrentUserUid() {
    return remoteDataSource.getCurrentUserUid();
  }

  /// Fetch user data from Firestore and return as domain entity.
  Future<AppUser> getUserData(String uid) async {
    final userDto = await remoteDataSource.getUserData(uid);
    return userDto.toDomain();
  }

  /// Update user profile data.
  Future<void> updateUserData(AppUser user) async {
    final userDto = UserDto.fromDomain(user);
    await remoteDataSource.setUserData(userDto);
  }

  /// Send password reset email.
  Future<void> sendPasswordReset(String email) async {
    await remoteDataSource.sendPasswordReset(email);
  }

  /// Sign out.
  Future<void> signOut() async {
    await remoteDataSource.signOut();
  }
}
