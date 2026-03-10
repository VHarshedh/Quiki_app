import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../domain/cart_item.dart';
import '../../infrastructure/repos/cart_repo.dart';

/// Cart state provider using ChangeNotifier.
class CartProvider extends ChangeNotifier {
  CartProvider({required this.cartRepo});

  final CartRepo cartRepo;

  List<CartItem> _items = [];
  bool _isLoading = false;
  String? _errorMessage;
  StreamSubscription<List<Map<String, dynamic>>>? _subscription;
  String? _currentUid;

  List<CartItem> get items => _items;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get itemCount => _items.length;

  double get subTotal => _items.fold(0, (sum, item) => sum + item.total);
  double get discount => _items.length >= 3 ? 12.0 : 0.0;
  double get deliveryFee => subTotal > 50 ? 0.0 : 5.0;
  double get total => subTotal + deliveryFee - discount;

  /// Start listening to cart items for a user.
  void listenToCart(String uid) {
    if (_currentUid == uid) return;
    _currentUid = uid;
    _subscription?.cancel();
    _isLoading = true;
    notifyListeners();

    _subscription = cartRepo.streamCartItems(uid).listen(
      (items) {
        _items = items.map((data) {
          return CartItem(
            id: data['id'] ?? '',
            productId: data['productId'] ?? '',
            name: data['name'] ?? '',
            category: data['category'] ?? '',
            price: (data['price'] as num?)?.toDouble() ?? 0.0,
            quantity: data['quantity'] as int? ?? 1,
            size: data['size'] ?? 'Regular',
            imageUrl: data['imageUrl'] ?? '',
          );
        }).toList();
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

  /// Add a product to the cart.
  Future<void> addToCart({
    required String uid,
    required String productId,
    required String name,
    required String category,
    required double price,
    String size = 'Regular',
    String imageUrl = '',
  }) async {
    try {
      await cartRepo.addItem(uid, {
        'productId': productId,
        'name': name,
        'category': category,
        'price': price,
        'quantity': 1,
        'size': size,
        'imageUrl': imageUrl,
      });
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  /// Update the quantity of a cart item.
  Future<void> updateQuantity(String uid, String itemId, int quantity) async {
    if (quantity < 1) return;
    try {
      await cartRepo.updateQuantity(uid, itemId, quantity);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  /// Remove a cart item.
  Future<void> removeItem(String uid, String itemId) async {
    try {
      await cartRepo.removeItem(uid, itemId);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  /// Clear the entire cart.
  Future<void> clearCart(String uid) async {
    try {
      await cartRepo.clearCart(uid);
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
