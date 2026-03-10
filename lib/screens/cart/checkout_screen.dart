import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../utils/app_theme.dart';
import '../../utils/app_routes.dart';
import '../../widgets/primary_button.dart';
import '../../features/cart/presentation/providers/cart_provider.dart';
import '../../features/address/presentation/providers/address_provider.dart';
import '../../auth/presentation/providers/auth_provider.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    final addressProvider = context.watch<AddressProvider>();
    final authProvider = context.watch<AuthProvider>();

    // Listen to addresses if authenticated
    if (authProvider.isAuthenticated) {
      addressProvider.listenToAddresses(authProvider.user.id);
    }

    final selectedAddress = addressProvider.selectedAddress;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shipping Address Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Shipping Address',
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w600)),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, AppRoutes.shippingAddress),
                  child: Text('CHANGE',
                      style: GoogleFonts.poppins(
                          color: AppColors.primary,
                          fontSize: 13,
                          fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, color: AppColors.primary, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(selectedAddress?.label ?? 'No address selected',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                      Text(
                          selectedAddress?.fullAddress ?? 'Please add a shipping address',
                          style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            // Order List
            Text('Order List',
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            ...cartProvider.items.map((item) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.cake, color: AppColors.primaryLight, size: 28),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.name,
                                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                            Text('${item.category} • x${item.quantity}',
                                style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                      Text('\$${item.total.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.w700)),
                    ],
                  ),
                )),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: PrimaryButton(
          text: 'Continue to Payment',
          onPressed: () => Navigator.pushNamed(context, AppRoutes.paymentMethod),
        ),
      ),
    );
  }
}
