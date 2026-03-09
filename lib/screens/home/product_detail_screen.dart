import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_theme.dart';
import '../../utils/app_routes.dart';
import '../../widgets/primary_button.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _qty = 1;
  String _size = 'Regular';
  bool _isFav = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Hero Image
          Stack(
            children: [
              Container(
                height: 320,
                width: double.infinity,
                color: AppColors.surface,
                child: const Icon(Icons.cake, size: 120, color: AppColors.primaryLight),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 8,
                left: 16,
                child: _circleBtn(Icons.arrow_back, () => Navigator.pop(context)),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 8,
                right: 16,
                child: _circleBtn(
                  _isFav ? Icons.favorite : Icons.favorite_border,
                  () => setState(() => _isFav = !_isFav),
                ),
              ),
            ],
          ),

          // Details
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text('Chocolate Cake',
                            style: GoogleFonts.poppins(
                                fontSize: 22, fontWeight: FontWeight.w700)),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: AppColors.star, size: 18),
                          const SizedBox(width: 4),
                          Text('4.8', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                          Text(' (1k+ Reviews)',
                              style: TextStyle(
                                  fontSize: 12, color: AppColors.textSecondary)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('Cake', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
                  const SizedBox(height: 16),
                  Text(
                    'A rich, moist chocolate cake made with premium cocoa powder and layered with velvety chocolate ganache. Perfect for celebrations or a sweet treat any day.',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Size Selection
                  Text('Size',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  Row(
                    children: ['Regular', 'Large'].map((s) {
                      final selected = s == _size;
                      return GestureDetector(
                        onTap: () => setState(() => _size = s),
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 28, vertical: 12),
                          decoration: BoxDecoration(
                            color: selected ? AppColors.primary : AppColors.surface,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(s,
                              style: TextStyle(
                                color: selected ? AppColors.white : AppColors.textPrimary,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Quantity
                  Row(
                    children: [
                      Text('Quantity',
                          style: GoogleFonts.poppins(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                      const Spacer(),
                      _qtyBtn(Icons.remove, () {
                        if (_qty > 1) setState(() => _qty--);
                      }),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text('$_qty',
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                      ),
                      _qtyBtn(Icons.add, () => setState(() => _qty++), filled: true),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Bottom Bar
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 16,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Price', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                    Text('\$${(50.0 * _qty).toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(
                            fontSize: 22, fontWeight: FontWeight.w700)),
                  ],
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: PrimaryButton(
                    text: 'Add to Cart',
                    onPressed: () => Navigator.pushNamed(context, AppRoutes.myCart),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.9),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 22),
      ),
    );
  }

  Widget _qtyBtn(IconData icon, VoidCallback onTap, {bool filled = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: filled ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon,
            size: 18, color: filled ? AppColors.white : AppColors.textPrimary),
      ),
    );
  }
}
