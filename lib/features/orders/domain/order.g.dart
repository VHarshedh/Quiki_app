// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppOrder _$AppOrderFromJson(Map<String, dynamic> json) => _AppOrder(
  id: json['id'] as String,
  userId: json['userId'] as String,
  items: (json['items'] as List<dynamic>)
      .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalAmount: (json['totalAmount'] as num).toDouble(),
  status: $enumDecode(_$OrderStatusEnumMap, json['status']),
  createdAt: DateTime.parse(json['createdAt'] as String),
  addressId: json['addressId'] as String? ?? '',
  paymentMethod: json['paymentMethod'] as String? ?? '',
  cancelNote: json['cancelNote'] as String? ?? '',
);

Map<String, dynamic> _$AppOrderToJson(_AppOrder instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'items': instance.items,
  'totalAmount': instance.totalAmount,
  'status': _$OrderStatusEnumMap[instance.status]!,
  'createdAt': instance.createdAt.toIso8601String(),
  'addressId': instance.addressId,
  'paymentMethod': instance.paymentMethod,
  'cancelNote': instance.cancelNote,
};

const _$OrderStatusEnumMap = {
  OrderStatus.active: 'active',
  OrderStatus.completed: 'completed',
  OrderStatus.cancelled: 'cancelled',
};
