import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Products
  Stream<QuerySnapshot> getProducts() {
    return _db.collection('products').snapshots();
  }

  Future<DocumentSnapshot> getProduct(String id) {
    return _db.collection('products').doc(id).get();
  }

  // Orders
  Stream<QuerySnapshot> getUserOrders(String userId) {
    return _db
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> createOrder(Map<String, dynamic> orderData) {
    return _db.collection('orders').add(orderData);
  }

  Future<void> updateOrderStatus(String orderId, String status) {
    return _db.collection('orders').doc(orderId).update({'status': status});
  }

  // User Profile
  Future<DocumentSnapshot> getUserProfile(String userId) {
    return _db.collection('users').doc(userId).get();
  }

  Future<void> updateUserProfile(String userId, Map<String, dynamic> data) {
    return _db.collection('users').doc(userId).set(data, SetOptions(merge: true));
  }

  // Addresses
  Stream<QuerySnapshot> getUserAddresses(String userId) {
    return _db.collection('users').doc(userId).collection('addresses').snapshots();
  }

  Future<void> addAddress(String userId, Map<String, dynamic> address) {
    return _db.collection('users').doc(userId).collection('addresses').add(address);
  }

  // Wallet
  Future<DocumentSnapshot> getWallet(String userId) {
    return _db.collection('wallets').doc(userId).get();
  }

  Stream<QuerySnapshot> getTransactions(String userId) {
    return _db
        .collection('wallets')
        .doc(userId)
        .collection('transactions')
        .orderBy('date', descending: true)
        .snapshots();
  }
}
