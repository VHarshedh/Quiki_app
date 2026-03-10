// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Product _$ProductFromJson(Map<String, dynamic> json) => _Product(
  id: json['id'] as String,
  name: json['name'] as String,
  category: json['category'] as String,
  price: (json['price'] as num).toDouble(),
  rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
  description: json['description'] as String? ?? '',
  imageUrl: json['imageUrl'] as String? ?? '',
  sizes:
      (json['sizes'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$ProductToJson(_Product instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'category': instance.category,
  'price': instance.price,
  'rating': instance.rating,
  'description': instance.description,
  'imageUrl': instance.imageUrl,
  'sizes': instance.sizes,
};
