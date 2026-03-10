import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../utils/app_theme.dart';
import '../../utils/app_routes.dart';
import '../../features/search/presentation/providers/search_provider.dart';
import '../../features/home/presentation/providers/products_provider.dart';
import '../../features/home/domain/product.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = context.watch<SearchProvider>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: AppColors.textHint, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _searchCtrl,
                              autofocus: true,
                              decoration: const InputDecoration(
                                hintText: 'Search...',
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                fillColor: Colors.transparent,
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(vertical: 12),
                              ),
                              onSubmitted: (query) {
                                searchProvider.search(query);
                                Navigator.pushNamed(context, AppRoutes.searchResults);
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _searchCtrl.clear(),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppColors.textHint.withValues(alpha: 0.3),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.close, size: 14, color: AppColors.textSecondary),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Recent Search
                    if (searchProvider.recentSearches.isNotEmpty) ...[
                      Text('Recent Search',
                          style: GoogleFonts.poppins(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 12),
                      ...List.generate(searchProvider.recentSearches.length, (i) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    _searchCtrl.text = searchProvider.recentSearches[i];
                                    searchProvider.search(searchProvider.recentSearches[i]);
                                    Navigator.pushNamed(context, AppRoutes.searchResults);
                                  },
                                  child: Text(searchProvider.recentSearches[i],
                                      style: TextStyle(
                                          fontSize: 14, color: AppColors.textSecondary)),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => searchProvider.removeRecentSearch(i),
                                child: const Icon(Icons.close, size: 16, color: AppColors.textHint),
                              ),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: 24),
                    ],

                    // Recent View
                    if (searchProvider.recentViews.isNotEmpty) ...[
                      Text('Recent View',
                          style: GoogleFonts.poppins(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 12),
                      ...List.generate(searchProvider.recentViews.length, (i) {
                        final Product item = searchProvider.recentViews[i];
                        return GestureDetector(
                          onTap: () {
                            context.read<ProductsProvider>().selectProduct(item);
                            Navigator.pushNamed(context, AppRoutes.productDetail);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 52,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    color: AppColors.surface,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(Icons.cake,
                                      color: AppColors.primaryLight, size: 26),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600, fontSize: 14)),
                                      Text(item.category,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors.textSecondary)),
                                    ],
                                  ),
                                ),
                                Text('\$${item.price.toStringAsFixed(2)}',
                                    style: const TextStyle(fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],

                    // Show hint if no recent data
                    if (searchProvider.recentSearches.isEmpty &&
                        searchProvider.recentViews.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 60),
                          child: Column(
                            children: [
                              Icon(Icons.search, size: 64, color: AppColors.textHint),
                              const SizedBox(height: 16),
                              Text('Start searching for cakes, desserts...',
                                  style: TextStyle(color: AppColors.textSecondary)),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
