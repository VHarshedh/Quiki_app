import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../domain/product.dart';
import '../../infrastructure/repos/products_repo.dart';

/// Products state provider using ChangeNotifier.
class ProductsProvider extends ChangeNotifier {
  ProductsProvider({required this.productsRepo}) {
    _init();
  }

  final ProductsRepo productsRepo;

  List<Product> _products = [];
  List<String> _categories = ['All'];
  String _selectedCategory = 'All';
  Product? _selectedProduct;
  bool _isLoading = true;
  String? _errorMessage;
  StreamSubscription<List<Product>>? _subscription;

  List<Product> get products {
    if (_selectedCategory == 'All') return _products;
    return _products
        .where((p) =>
            p.category.toLowerCase() == _selectedCategory.toLowerCase())
        .toList();
  }

  List<Product> get allProducts => _products;
  List<String> get categories => _categories;
  String get selectedCategory => _selectedCategory;
  Product? get selectedProduct => _selectedProduct;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void _init() {
    _subscription = productsRepo.streamProducts().listen(
      (products) {
        _products = products;
        _categories = [
          'All',
          ...{...products.map((p) => p.category)},
        ];
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

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void selectProduct(Product product) {
    _selectedProduct = product;
    notifyListeners();
  }

  Future<void> loadProduct(String id) async {
    try {
      _selectedProduct = await productsRepo.getProduct(id);
      notifyListeners();
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
