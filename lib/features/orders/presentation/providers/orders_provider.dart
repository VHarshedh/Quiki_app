import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../../infrastructure/repos/orders_repo.dart';

/// Orders state provider using ChangeNotifier.
class OrdersProvider extends ChangeNotifier {
  OrdersProvider({required this.ordersRepo});

  final OrdersRepo ordersRepo;

  List<Map<String, dynamic>> _allOrders = [];
  bool _isLoading = false;
  String? _errorMessage;
  StreamSubscription<List<Map<String, dynamic>>>? _subscription;
  String? _currentUid;

  List<Map<String, dynamic>> get activeOrders =>
      _allOrders.where((o) => o['status'] == 'active').toList();

  List<Map<String, dynamic>> get completedOrders =>
      _allOrders.where((o) => o['status'] == 'completed').toList();

  List<Map<String, dynamic>> get cancelledOrders =>
      _allOrders.where((o) => o['status'] == 'cancelled').toList();

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Start listening to orders for a user.
  void listenToOrders(String uid) {
    if (_currentUid == uid) return;
    _currentUid = uid;
    _subscription?.cancel();
    _isLoading = true;
    notifyListeners();

    _subscription = ordersRepo.streamUserOrders(uid).listen(
      (orders) {
        _allOrders = orders;
        _isLoading = false;
        notifyListeners();
      },
      onError: (e) {
        _errorMessage = e.toString();
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  /// Place a new order from checkout.
  Future<String?> placeOrder({
    required String userId,
    required List<Map<String, dynamic>> items,
    required double totalAmount,
    required String addressId,
    required String paymentMethod,
  }) async {
    try {
      final orderId = await ordersRepo.createOrder({
        'userId': userId,
        'items': items,
        'totalAmount': totalAmount,
        'status': 'active',
        'addressId': addressId,
        'paymentMethod': paymentMethod,
        'createdAt': Timestamp.now(),
      });
      return orderId;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return null;
    }
  }

  /// Cancel an order.
  Future<void> cancelOrder(String orderId) async {
    try {
      await ordersRepo.updateOrderStatus(orderId, 'cancelled');
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
