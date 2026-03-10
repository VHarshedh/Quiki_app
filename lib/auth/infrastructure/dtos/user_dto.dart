import 'package:firebase_auth/firebase_auth.dart' as f_auth;
import '../../domain/user.dart';

/// Data Transfer Object for [AppUser].
/// Handles conversion between Firestore JSON, Firebase Auth User, and domain entity.
class UserDto {
  const UserDto({
    required this.id,
    required this.email,
    this.name,
    this.phone,
    this.image,
  });

  final String id;
  final String email;
  final String? name;
  final String? phone;
  final String? image;

  /// Create from Firestore document data.
  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      image: json['image'] as String?,
    );
  }

  /// Create from Firebase Auth UserCredential.
  factory UserDto.fromUserCredential(f_auth.User user) {
    return UserDto(
      id: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? '',
      phone: user.phoneNumber ?? '',
      image: user.photoURL ?? '',
    );
  }

  /// Create from domain entity.
  factory UserDto.fromDomain(AppUser user) {
    return UserDto(
      id: user.id,
      email: user.email,
      name: user.name,
      phone: user.phone,
      image: user.image,
    );
  }

  /// Convert to Firestore JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'image': image,
    };
  }

  /// Convert to domain entity.
  AppUser toDomain() {
    return AppUser(
      id: id,
      email: email,
      name: name,
      phone: phone,
      image: image,
    );
  }
}
