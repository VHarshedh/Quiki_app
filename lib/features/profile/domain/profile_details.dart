import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_details.freezed.dart';
part 'profile_details.g.dart';

@freezed
abstract class ProfileDetails with _$ProfileDetails {
  const factory ProfileDetails({
    @Default('') String name,
    @Default('') String phone,
    @Default('') String image,
  }) = _ProfileDetails;

  const ProfileDetails._();

  factory ProfileDetails.fromJson(Map<String, dynamic> json) =>
      _$ProfileDetailsFromJson(json);
}
