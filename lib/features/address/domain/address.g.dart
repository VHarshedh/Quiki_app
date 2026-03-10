// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Address _$AddressFromJson(Map<String, dynamic> json) => _Address(
  id: json['id'] as String,
  label: json['label'] as String? ?? 'Home',
  street: json['street'] as String? ?? '',
  city: json['city'] as String? ?? '',
  state: json['state'] as String? ?? '',
  zipCode: json['zipCode'] as String? ?? '',
  isDefault: json['isDefault'] as bool? ?? false,
);

Map<String, dynamic> _$AddressToJson(_Address instance) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'street': instance.street,
  'city': instance.city,
  'state': instance.state,
  'zipCode': instance.zipCode,
  'isDefault': instance.isDefault,
};
