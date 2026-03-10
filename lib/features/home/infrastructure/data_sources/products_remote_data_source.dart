import '../../../../core/infrastructure/network/firebase_firestore_facade.dart';
import '../dtos/product_dto.dart';

/// Remote data source for products from Firestore.
class ProductsRemoteDataSource {
  ProductsRemoteDataSource({required this.firebaseFirestore});

  final FirebaseFirestoreFacade firebaseFirestore;

  static const String productsCollectionPath = 'products';

  /// Stream all products in real-time.
  Stream<List<ProductDto>> streamProducts() {
    return firebaseFirestore
        .streamCollection(path: productsCollectionPath)
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProductDto.fromJson(doc.data(), docId: doc.id);
      }).toList();
    });
  }

  /// Get a single product by ID.
  Future<ProductDto> getProduct(String id) async {
    final doc = await firebaseFirestore.getData(
      path: '$productsCollectionPath/$id',
    );
    final data = doc.data();
    if (data != null) {
      return ProductDto.fromJson(data, docId: doc.id);
    }
    throw Exception('Product not found');
  }

  /// Get products by category.
  Stream<List<ProductDto>> streamProductsByCategory(String category) {
    return firebaseFirestore
        .streamCollection(
      path: productsCollectionPath,
      queryBuilder: (ref) => ref.where('category', isEqualTo: category),
    )
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProductDto.fromJson(doc.data(), docId: doc.id);
      }).toList();
    });
  }
}
