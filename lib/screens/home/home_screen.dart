import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../utils/app_theme.dart';
import '../../utils/app_routes.dart';
import '../../widgets/product_card.dart';
import '../../features/home/presentation/providers/products_provider.dart';
import '../../features/home/domain/product.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<ProductsProvider>(
          builder: (context, productsProvider, _) {
            return CustomScrollView(
              slivers: [
                // Location Header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Deliver to',
                                  style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  const Icon(Icons.location_on, color: AppColors.primary, size: 18),
                                  const SizedBox(width: 4),
                                  Text('New York, USA',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600, fontSize: 15)),
                                  const Icon(Icons.keyboard_arrow_down, size: 20),
                                ],
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.notifications_outlined,
                                color: AppColors.textPrimary),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Search Bar
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, AppRoutes.search),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search, color: AppColors.textHint),
                            const SizedBox(width: 12),
                            Text('Search for cakes, desserts...',
                                style: TextStyle(color: AppColors.textHint, fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Promo Banner
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, Color(0xFFA0522D)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('30% Off',
                              style: GoogleFonts.poppins(
                                  color: AppColors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700)),
                          Text('on your first order!',
                              style: GoogleFonts.poppins(
                                  color: AppColors.white.withValues(alpha: 0.8), fontSize: 14)),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text('Order Now',
                                style: GoogleFonts.poppins(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Categories (dynamic from Firestore)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 0, 16),
                    child: SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: productsProvider.categories.length,
                        itemBuilder: (ctx, i) {
                          final category = productsProvider.categories[i];
                          final selected = category == productsProvider.selectedCategory;
                          return GestureDetector(
                            onTap: () => productsProvider.selectCategory(category),
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: selected ? AppColors.primary : AppColors.surface,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                category,
                                style: TextStyle(
                                  color: selected ? AppColors.white : AppColors.textPrimary,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                // Loading / Error / Product Grid
                if (productsProvider.isLoading)
                  const SliverToBoxAdapter(
                    child: Center(child: Padding(
                      padding: EdgeInsets.all(40),
                      child: CircularProgressIndicator(),
                    )),
                  )
                else if (productsProvider.errorMessage != null)
                  SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(40),
                        child: Text(
                          productsProvider.errorMessage!,
                          style: TextStyle(color: AppColors.error),
                        ),
                      ),
                    ),
                  )
                else if (productsProvider.products.isEmpty)
                  SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(40),
                        child: Column(
                          children: [
                            Icon(Icons.inbox_outlined, size: 64, color: AppColors.textHint),
                            const SizedBox(height: 16),
                            Text('No products found',
                                style: TextStyle(color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.72,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 14,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (ctx, i) {
                          final Product p = productsProvider.products[i];
                          return ProductCard(
                            name: p.name,
                            category: p.category,
                            price: p.price.toStringAsFixed(2),
                            rating: p.rating,
                            onTap: () {
                              productsProvider.selectProduct(p);
                              Navigator.pushNamed(context, AppRoutes.productDetail);
                            },
                            onAdd: () => ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${p.name} added to cart!')),
                            ),
                          );
                        },
                        childCount: productsProvider.products.length,
                      ),
                    ),
                  ),

                const SliverToBoxAdapter(child: SizedBox(height: 20)),
              ],
            );
          },
        ),
      ),
    );
  }
}
