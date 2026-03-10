import '../../../../core/infrastructure/network/firebase_firestore_facade.dart';

/// Remote data source for orders from Firestore.
class OrdersRemoteDataSource {
  OrdersRemoteDataSource({required this.firebaseFirestore});

  final FirebaseFirestoreFacade firebaseFirestore;

  static const String ordersCollectionPath = 'orders';

  /// Stream all orders for a user (real-time).
  Stream<List<Map<String, dynamic>>> streamUserOrders(String userId) {
    return firebaseFirestore
        .streamCollection(
      path: ordersCollectionPath,
      queryBuilder: (ref) => ref
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true),
    )
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }

  /// Create a new order.
  Future<String> createOrder(Map<String, dynamic> orderData) async {
    final docRef = await firebaseFirestore.addData(
      collectionPath: ordersCollectionPath,
      data: orderData,
    );
    return docRef.id;
  }

  /// Update order status.
  Future<void> updateOrderStatus(String orderId, String status) async {
    await firebaseFirestore.updateData(
      path: '$ordersCollectionPath/$orderId',
      data: {'status': status},
    );
  }

  /// Get a single order by ID.
  Future<Map<String, dynamic>> getOrder(String orderId) async {
    final doc = await firebaseFirestore.getData(
      path: '$ordersCollectionPath/$orderId',
    );
    final data = doc.data();
    if (data != null) {
      data['id'] = doc.id;
      return data;
    }
    throw Exception('Order not found');
  }
}
