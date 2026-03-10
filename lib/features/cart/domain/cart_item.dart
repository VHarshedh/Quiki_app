import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item.freezed.dart';
part 'cart_item.g.dart';

@freezed
abstract class CartItem with _$CartItem {
  const factory CartItem({
    required String id,
    required String productId,
    required String name,
    required String category,
    required double price,
    @Default(1) int quantity,
    @Default('Regular') String size,
    @Default('') String imageUrl,
  }) = _CartItem;

  const CartItem._();

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  double get total => price * quantity;
}
