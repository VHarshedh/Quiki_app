import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_theme.dart';
import '../../utils/app_routes.dart';
import '../../widgets/product_card.dart';

class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen({super.key});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;

  final _products = [
    {'name': 'Chocolate Creamy', 'price': '35.00', 'rating': 4.8},
    {'name': 'Chocolate Creamy', 'price': '45.00', 'rating': 4.9},
    {'name': 'Raspberry Cake', 'price': '24.00', 'rating': 4.8},
    {'name': 'Citrus Bliss Cake', 'price': '32.00', 'rating': 4.9},
  ];

  final _bakeries = [
    {
      'name': 'Rise & Shine Bakery Co.',
      'categories': 'Cup Cake, Cookies, Donuts, Breads, Cake...',
      'address': '8502 Preston Rd, Inglewood, Maine 98380',
      'delivery': '15 mins • 2.5 km • Free Delivery',
      'rating': '4.8',
    },
    {
      'name': 'Sweet Confections Cottage',
      'categories': 'Cup Cake, Cookies, Donuts, Breads, Cake...',
      'address': '4140 Parker Rd, Allentown, New Mexico 31134',
      'delivery': '15 mins • 1.5 km • Free Delivery',
      'rating': '4.8',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
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
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: AppColors.textHint, size: 20),
                          const SizedBox(width: 8),
                          Text('Cake',
                              style: GoogleFonts.poppins(fontSize: 14)),
                          const Spacer(),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppColors.textHint.withValues(alpha: 0.3),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.close, size: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, AppRoutes.filter),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.tune, color: AppColors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),

            // Tabs
            TabBar(
              controller: _tabCtrl,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorColor: AppColors.primary,
              indicatorWeight: 2.5,
              labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              tabs: const [
                Tab(text: 'Products'),
                Tab(text: 'Bakeries'),
              ],
            ),

            // Tab Views
            Expanded(
              child: TabBarView(
                controller: _tabCtrl,
                children: [
                  _buildProductsTab(),
                  _buildBakeriesTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bakery Header
          Row(
            children: [
              Text('Zestful Zephyr Bakery',
                  style: GoogleFonts.poppins(
                      fontSize: 15, fontWeight: FontWeight.w600)),
            ],
          ),
          Row(
            children: [
              Container(
                width: 8, height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.success, shape: BoxShape.circle),
              ),
              const SizedBox(width: 6),
              Text('15 min • 1.5km • Free Delivery',
                  style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.72,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
            ),
            itemCount: _products.length,
            itemBuilder: (ctx, i) {
              final p = _products[i];
              return ProductCard(
                name: p['name'] as String,
                category: 'Cake',
                price: p['price'] as String,
                rating: p['rating'] as double,
                onTap: () => Navigator.pushNamed(context, AppRoutes.productDetail),
                onAdd: () {},
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBakeriesTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _bakeries.length,
      itemBuilder: (ctx, i) {
        final b = _bakeries[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: const Center(
                  child: Icon(Icons.storefront, size: 50, color: AppColors.primaryLight),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(b['name']!,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 4),
                    Text(b['categories']!,
                        style: TextStyle(
                            fontSize: 12, color: AppColors.textSecondary)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined,
                            size: 14, color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(b['address']!,
                              style: TextStyle(
                                  fontSize: 12, color: AppColors.textSecondary)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(b['delivery']!,
                            style: TextStyle(
                                fontSize: 12, color: AppColors.textSecondary)),
                        const Spacer(),
                        const Icon(Icons.star, size: 14, color: AppColors.star),
                        const SizedBox(width: 4),
                        Text('${b['rating']} (1k+ Reviews)',
                            style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
