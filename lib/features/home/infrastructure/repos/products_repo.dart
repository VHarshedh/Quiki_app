import '../../domain/product.dart';
import '../data_sources/products_remote_data_source.dart';

/// Products repository that wraps the data source
/// and maps DTOs → domain entities.
class ProductsRepo {
  ProductsRepo({required this.remoteDataSource});

  final ProductsRemoteDataSource remoteDataSource;

  /// Stream all products (real-time from Firestore).
  Stream<List<Product>> streamProducts() {
    return remoteDataSource.streamProducts().map(
          (dtos) => dtos.map((dto) => dto.toDomain()).toList(),
        );
  }

  /// Get a single product by ID.
  Future<Product> getProduct(String id) async {
    final dto = await remoteDataSource.getProduct(id);
    return dto.toDomain();
  }

  /// Stream products filtered by category (real-time).
  Stream<List<Product>> streamProductsByCategory(String category) {
    return remoteDataSource.streamProductsByCategory(category).map(
          (dtos) => dtos.map((dto) => dto.toDomain()).toList(),
        );
  }
}
