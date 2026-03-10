import 'package:flutter/foundation.dart';
import '../../../home/domain/product.dart';
import '../../infrastructure/repos/search_repo.dart';

/// Search state provider using ChangeNotifier.
class SearchProvider extends ChangeNotifier {
  SearchProvider({required this.searchRepo});

  final SearchRepo searchRepo;

  List<Product> _results = [];
  List<String> _recentSearches = [];
  List<Product> _recentViews = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Product> get results => _results;
  List<String> get recentSearches => _recentSearches;
  List<Product> get recentViews => _recentViews;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Search products by name.
  Future<void> search(String query) async {
    if (query.trim().isEmpty) return;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final dtos = await searchRepo.searchProducts(query);
      _results = dtos.map((dto) => dto.toDomain()).toList();

      // Add to recent searches (keep last 10)
      _recentSearches.remove(query);
      _recentSearches.insert(0, query);
      if (_recentSearches.length > 10) {
        _recentSearches = _recentSearches.sublist(0, 10);
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Filter by category.
  Future<void> filterByCategory(String category) async {
    _isLoading = true;
    notifyListeners();

    try {
      final dtos = await searchRepo.filterByCategory(category);
      _results = dtos.map((dto) => dto.toDomain()).toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Filter by price range.
  Future<void> filterByPriceRange(double min, double max) async {
    _isLoading = true;
    notifyListeners();

    try {
      final dtos = await searchRepo.filterByPriceRange(min, max);
      _results = dtos.map((dto) => dto.toDomain()).toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Add a product to recent views.
  void addRecentView(Product product) {
    _recentViews.removeWhere((p) => p.id == product.id);
    _recentViews.insert(0, product);
    if (_recentViews.length > 10) {
      _recentViews = _recentViews.sublist(0, 10);
    }
    notifyListeners();
  }

  /// Remove a recent search.
  void removeRecentSearch(int index) {
    if (index >= 0 && index < _recentSearches.length) {
      _recentSearches.removeAt(index);
      notifyListeners();
    }
  }

  /// Clear all results.
  void clearResults() {
    _results = [];
    notifyListeners();
  }
}
