import 'package:freezed_annotation/freezed_annotation.dart';
import '../../cart/domain/cart_item.dart';

part 'order.freezed.dart';
part 'order.g.dart';

enum OrderStatus {
  active,
  completed,
  cancelled,
}

@freezed
abstract class AppOrder with _$AppOrder {
  const factory AppOrder({
    required String id,
    required String userId,
    required List<CartItem> items,
    required double totalAmount,
    required OrderStatus status,
    required DateTime createdAt,
    @Default('') String addressId,
    @Default('') String paymentMethod,
    @Default('') String cancelNote,
  }) = _AppOrder;

  const AppOrder._();

  factory AppOrder.fromJson(Map<String, dynamic> json) =>
      _$AppOrderFromJson(json);
}
