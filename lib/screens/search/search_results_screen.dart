import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../utils/app_theme.dart';
import '../../utils/app_routes.dart';
import '../../widgets/product_card.dart';
import '../../features/search/presentation/providers/search_provider.dart';
import '../../features/home/presentation/providers/products_provider.dart';
import '../../features/home/domain/product.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchProvider = context.watch<SearchProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Search Results'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.filter),
          ),
        ],
      ),
      body: searchProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : searchProvider.results.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 64, color: AppColors.textHint),
                      const SizedBox(height: 16),
                      Text('No results found',
                          style: GoogleFonts.poppins(
                              fontSize: 16, color: AppColors.textSecondary)),
                    ],
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.72,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                  ),
                  itemCount: searchProvider.results.length,
                  itemBuilder: (ctx, i) {
                    final Product p = searchProvider.results[i];
                    return ProductCard(
                      name: p.name,
                      category: p.category,
                      price: p.price.toStringAsFixed(2),
                      rating: p.rating,
                      onTap: () {
                        context.read<ProductsProvider>().selectProduct(p);
                        searchProvider.addRecentView(p);
                        Navigator.pushNamed(context, AppRoutes.productDetail);
                      },
                      onAdd: () => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${p.name} added to cart!')),
                      ),
                    );
                  },
                ),
    );
  }
}
