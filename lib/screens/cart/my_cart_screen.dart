import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_theme.dart';
import '../../utils/app_routes.dart';
import '../../widgets/primary_button.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  final List<Map<String, dynamic>> _items = [
    {'name': 'Chocolate Cake', 'category': 'Cake', 'price': 50.00, 'qty': 1},
    {'name': 'Divine Cupcake Delights', 'category': 'Cup Cake', 'price': 12.00, 'qty': 1},
    {'name': 'Vanilla Velvet Delights', 'category': 'Cake', 'price': 20.00, 'qty': 1},
    {'name': 'Brown Breads', 'category': 'Bread', 'price': 10.00, 'qty': 1},
  ];

  double get subTotal => _items.fold(0, (s, i) => s + (i['price'] as double) * (i['qty'] as int));
  double get discount => 12.00;
  double get deliveryFee => 0.00;
  double get total => subTotal + deliveryFee - discount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('My Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _items.length,
              itemBuilder: (ctx, i) {
                final item = _items[i];
                return Dismissible(
                  key: Key(item['name']),
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
                  onDismissed: (_) => setState(() => _items.removeAt(i)),
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
                          child: const Icon(Icons.cake, color: AppColors.primaryLight, size: 35),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['name'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600, fontSize: 14)),
                              const SizedBox(height: 4),
                              Text(item['category'],
                                  style: TextStyle(
                                      fontSize: 12, color: AppColors.textSecondary)),
                              const SizedBox(height: 4),
                              Text('\$${item['price'].toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700, fontSize: 14)),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            _qtyButton(Icons.remove, () {
                              if ((item['qty'] as int) > 1) {
                                setState(() => item['qty'] = item['qty'] - 1);
                              }
                            }),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Text('${item['qty']}',
                                  style: const TextStyle(fontWeight: FontWeight.w600)),
                            ),
                            _qtyButton(Icons.add, () {
                              setState(() => item['qty'] = item['qty'] + 1);
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
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
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
                            hintStyle: TextStyle(color: AppColors.textHint),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text('Apply',
                            style: TextStyle(
                                color: AppColors.white, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _summaryRow('Sub-Total', '\$${subTotal.toStringAsFixed(2)}'),
                _summaryRow('Delivery Fee', '\$${deliveryFee.toStringAsFixed(2)}'),
                _summaryRow('Discount', '-\$${discount.toStringAsFixed(2)}'),
                const Divider(height: 20),
                _summaryRow('Total Cost', '\$${total.toStringAsFixed(2)}', isBold: true),
                const SizedBox(height: 16),
                PrimaryButton(
                  text: 'Proceed to Checkout',
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.checkout),
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
