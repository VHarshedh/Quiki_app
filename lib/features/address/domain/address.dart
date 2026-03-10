import 'package:freezed_annotation/freezed_annotation.dart';

part 'address.freezed.dart';
part 'address.g.dart';

@freezed
abstract class Address with _$Address {
  const factory Address({
    required String id,
    @Default('Home') String label,
    @Default('') String street,
    @Default('') String city,
    @Default('') String state,
    @Default('') String zipCode,
    @Default(false) bool isDefault,
  }) = _Address;

  const Address._();

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  String get fullAddress => '$street, $city, $state $zipCode';
}
