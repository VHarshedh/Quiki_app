// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileDetails _$ProfileDetailsFromJson(Map<String, dynamic> json) =>
    _ProfileDetails(
      name: json['name'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      image: json['image'] as String? ?? '',
    );

Map<String, dynamic> _$ProfileDetailsToJson(_ProfileDetails instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'image': instance.image,
    };
