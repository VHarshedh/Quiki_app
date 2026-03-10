import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    required String email,
    String? name,
    String? phone,
    String? image,
  }) = _AppUser;

  const AppUser._();

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  /// Returns an empty guest user.
  static const AppUser guest = AppUser(id: '', email: '');

  bool get isGuest => id.isEmpty;
}
