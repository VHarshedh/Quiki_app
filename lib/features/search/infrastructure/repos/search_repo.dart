import '../../../../core/infrastructure/network/firebase_firestore_facade.dart';
import '../../../home/infrastructure/dtos/product_dto.dart';

/// Search repository that queries the products collection in Firestore.
class SearchRepo {
  SearchRepo({required this.firebaseFirestore});

  final FirebaseFirestoreFacade firebaseFirestore;

  static const String productsCollectionPath = 'products';

  /// Search products by name (client-side filtering since Firestore
  /// doesn't support full-text search natively).
  Future<List<ProductDto>> searchProducts(String query) async {
    final snapshot = await firebaseFirestore.getCollectionData(
      path: productsCollectionPath,
    );
    final lowerQuery = query.toLowerCase();
    return snapshot.docs
        .map((doc) => ProductDto.fromJson(doc.data(), docId: doc.id))
        .where((dto) => dto.name.toLowerCase().contains(lowerQuery))
        .toList();
  }

  /// Filter products by category.
  Future<List<ProductDto>> filterByCategory(String category) async {
    final snapshot = await firebaseFirestore.getCollectionData(
      path: productsCollectionPath,
      queryBuilder: (ref) => ref.where('category', isEqualTo: category),
    );
    return snapshot.docs
        .map((doc) => ProductDto.fromJson(doc.data(), docId: doc.id))
        .toList();
  }

  /// Filter products by price range.
  Future<List<ProductDto>> filterByPriceRange(
      double minPrice, double maxPrice) async {
    final snapshot = await firebaseFirestore.getCollectionData(
      path: productsCollectionPath,
      queryBuilder: (ref) => ref
          .where('price', isGreaterThanOrEqualTo: minPrice)
          .where('price', isLessThanOrEqualTo: maxPrice),
    );
    return snapshot.docs
        .map((doc) => ProductDto.fromJson(doc.data(), docId: doc.id))
        .toList();
  }
}
