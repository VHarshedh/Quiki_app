import '../data_sources/orders_remote_data_source.dart';

/// Orders repository wrapping the data source.
class OrdersRepo {
  OrdersRepo({required this.remoteDataSource});

  final OrdersRemoteDataSource remoteDataSource;

  /// Stream all orders for a user.
  Stream<List<Map<String, dynamic>>> streamUserOrders(String userId) {
    return remoteDataSource.streamUserOrders(userId);
  }

  /// Create a new order.
  Future<String> createOrder(Map<String, dynamic> orderData) {
    return remoteDataSource.createOrder(orderData);
  }

  /// Update order status.
  Future<void> updateOrderStatus(String orderId, String status) {
    return remoteDataSource.updateOrderStatus(orderId, status);
  }

  /// Get a single order.
  Future<Map<String, dynamic>> getOrder(String orderId) {
    return remoteDataSource.getOrder(orderId);
  }
}
