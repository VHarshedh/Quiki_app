import '../../../../core/infrastructure/network/firebase_firestore_facade.dart';

/// Cart repository storing cart items in Firestore under users/{uid}/cart.
class CartRepo {
  CartRepo({required this.firebaseFirestore});

  final FirebaseFirestoreFacade firebaseFirestore;

  String _cartPath(String uid) => 'users/$uid/cart';
  String _cartItemPath(String uid, String itemId) => 'users/$uid/cart/$itemId';

  /// Stream all cart items for a user.
  Stream<List<Map<String, dynamic>>> streamCartItems(String uid) {
    return firebaseFirestore.streamCollection(path: _cartPath(uid)).map(
      (snapshot) => snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList(),
    );
  }

  /// Add an item to the cart.
  Future<void> addItem(String uid, Map<String, dynamic> itemData) async {
    await firebaseFirestore.addData(
      collectionPath: _cartPath(uid),
      data: itemData,
    );
  }

  /// Update the quantity of a cart item.
  Future<void> updateQuantity(String uid, String itemId, int quantity) async {
    await firebaseFirestore.updateData(
      path: _cartItemPath(uid, itemId),
      data: {'quantity': quantity},
    );
  }

  /// Remove an item from the cart.
  Future<void> removeItem(String uid, String itemId) async {
    await firebaseFirestore.deleteData(path: _cartItemPath(uid, itemId));
  }

  /// Clear all cart items for a user.
  Future<void> clearCart(String uid) async {
    final snapshot = await firebaseFirestore.getCollectionData(
      path: _cartPath(uid),
    );
    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}
