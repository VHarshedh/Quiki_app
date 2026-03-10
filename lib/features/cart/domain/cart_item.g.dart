// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CartItem _$CartItemFromJson(Map<String, dynamic> json) => _CartItem(
  id: json['id'] as String,
  productId: json['productId'] as String,
  name: json['name'] as String,
  category: json['category'] as String,
  price: (json['price'] as num).toDouble(),
  quantity: (json['quantity'] as num?)?.toInt() ?? 1,
  size: json['size'] as String? ?? 'Regular',
  imageUrl: json['imageUrl'] as String? ?? '',
);

Map<String, dynamic> _$CartItemToJson(_CartItem instance) => <String, dynamic>{
  'id': instance.id,
  'productId': instance.productId,
  'name': instance.name,
  'category': instance.category,
  'price': instance.price,
  'quantity': instance.quantity,
  'size': instance.size,
  'imageUrl': instance.imageUrl,
};
