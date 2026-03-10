import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/app_theme.dart';
import '../../utils/app_routes.dart';
import '../../widgets/primary_button.dart';
import '../../features/cart/presentation/providers/cart_provider.dart';
import '../../auth/presentation/providers/auth_provider.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final cartProvider = context.watch<CartProvider>();

    // Start listening if not yet
    if (authProvider.isAuthenticated) {
      cartProvider.listenToCart(authProvider.user.id);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('My Cart'),
      ),
      body: !authProvider.isAuthenticated
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 64, color: AppColors.textHint),
                  const SizedBox(height: 16),
                  Text('Please login to view your cart',
                      style: TextStyle(color: AppColors.textSecondary)),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    text: 'Login',
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.login, (r) => false),
                  ),
                ],
              ),
            )
          : cartProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : cartProvider.items.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart_outlined,
                              size: 64, color: AppColors.textHint),
                          const SizedBox(height: 16),
                          Text('Your cart is empty',
                              style: TextStyle(
                                  fontSize: 16, color: AppColors.textSecondary)),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: cartProvider.items.length,
                            itemBuilder: (ctx, i) {
                              final item = cartProvider.items[i];
                              return Dismissible(
                                key: Key(item.id),
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.only(right: 20),
                                  margin: const EdgeInsets.only(bottom: 12),
                                  decoration: BoxDecoration(
                                    color: AppColors.error.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: const Icon(Icons.delete, color: AppColors.error),
                                ),
                                onDismissed: (_) => cartProvider.removeItem(
                                    authProvider.user.id, item.id),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(16),
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
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          color: AppColors.surface,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: const Icon(Icons.cake,
                                            color: AppColors.primaryLight, size: 35),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(item.name,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14)),
                                            const SizedBox(height: 4),
                                            Text(item.category,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: AppColors.textSecondary)),
                                            const SizedBox(height: 4),
                                            Text(
                                                '\$${item.price.toStringAsFixed(2)}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14)),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          _qtyButton(Icons.remove, () {
                                            if (item.quantity > 1) {
                                              cartProvider.updateQuantity(
                                                  authProvider.user.id,
                                                  item.id,
                                                  item.quantity - 1);
                                            }
                                          }),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Text('${item.quantity}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600)),
                                          ),
                                          _qtyButton(Icons.add, () {
                                            cartProvider.updateQuantity(
                                                authProvider.user.id,
                                                item.id,
                                                item.quantity + 1);
                                          }, filled: true),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius:
                                const BorderRadius.vertical(top: Radius.circular(24)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 16,
                                offset: const Offset(0, -4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: 'Promo Code',
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          fillColor: Colors.transparent,
                                          filled: true,
                                          hintStyle:
                                              TextStyle(color: AppColors.textHint),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Text('Apply',
                                          style: TextStyle(
                                              color: AppColors.white,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              _summaryRow('Sub-Total',
                                  '\$${cartProvider.subTotal.toStringAsFixed(2)}'),
                              _summaryRow('Delivery Fee',
                                  '\$${cartProvider.deliveryFee.toStringAsFixed(2)}'),
                              _summaryRow('Discount',
                                  '-\$${cartProvider.discount.toStringAsFixed(2)}'),
                              const Divider(height: 20),
                              _summaryRow('Total Cost',
                                  '\$${cartProvider.total.toStringAsFixed(2)}',
                                  isBold: true),
                              const SizedBox(height: 16),
                              PrimaryButton(
                                text: 'Proceed to Checkout',
                                onPressed: () =>
                                    Navigator.pushNamed(context, AppRoutes.checkout),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap, {bool filled = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: filled ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon,
            size: 16, color: filled ? AppColors.white : AppColors.textPrimary),
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                color: isBold ? AppColors.textPrimary : AppColors.textSecondary,
                fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
              )),
          Text(value,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
              )),
        ],
      ),
    );
  }
}
