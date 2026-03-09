import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_theme.dart';
import '../../widgets/primary_button.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  int _selected = 0;

  final _addresses = [
    {'label': 'Home', 'address': '1901 Thornridge Cir. Shiloh, Hawaii 81063', 'icon': Icons.home_outlined},
    {'label': 'Office', 'address': '4517 Washington Ave, Manchester, Kentucky 39495', 'icon': Icons.business_outlined},
    {'label': "Parent's House", 'address': '8502 Preston Rd, Inglewood, Maine 98380', 'icon': Icons.family_restroom_outlined},
    {'label': "Friend's House", 'address': '2464 Royal Ln, Mesa, New Jersey 45463', 'icon': Icons.people_outline},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Shipping Address'),
      ),
      body: RadioGroup<int>(
        groupValue: _selected,
        onChanged: (v) => setState(() => _selected = v!),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
            Expanded(
              child: ListView.builder(
                itemCount: _addresses.length,
                itemBuilder: (ctx, i) {
                  final addr = _addresses[i];
                  return GestureDetector(
                    onTap: () => setState(() => _selected = i),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: _selected == i ? AppColors.primary : AppColors.border,
                          width: _selected == i ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(addr['icon'] as IconData,
                              color: AppColors.primary, size: 24),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(addr['label'] as String,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(height: 4),
                                Text(addr['address'] as String,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textSecondary)),
                              ],
                            ),
                          ),
                          Radio<int>(
                            value: i,
                            activeColor: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Add New Address
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 16),
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text('Add New Shipping Address'),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.primary.withValues(alpha: 0.4)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            PrimaryButton(
              text: 'Apply',
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      ),
    );
  }
}

