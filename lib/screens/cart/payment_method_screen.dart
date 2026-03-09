import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_theme.dart';
import '../../utils/app_routes.dart';
import '../../widgets/primary_button.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String _selected = 'cash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Payment Methods'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cash
            _sectionTitle('Cash'),
            _paymentOption('cash', 'Cash', Icons.money),
            const SizedBox(height: 20),

            // Wallet
            _sectionTitle('Wallet'),
            _paymentOption('wallet', 'Wallet', Icons.account_balance_wallet_outlined),
            const SizedBox(height: 20),

            // Credit & Debit Card
            _sectionTitle('Credit & Debit Card'),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, AppRoutes.addCard),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.credit_card, color: AppColors.primary),
                    const SizedBox(width: 12),
                    Text('Add Card',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                    const Spacer(),
                    const Icon(Icons.chevron_right, color: AppColors.textHint),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // More Payment Options
            _sectionTitle('More Payment Options'),
            _paymentOption('paypal', 'Paypal', Icons.paypal_outlined),
            const SizedBox(height: 8),
            _paymentOption('apple', 'Apple Pay', Icons.apple),
            const SizedBox(height: 8),
            _paymentOption('google', 'Google Pay', Icons.g_mobiledata),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: PrimaryButton(
          text: 'Confirm Payment',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Payment confirmed!')),
            );
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(title,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
    );
  }

  Widget _paymentOption(String value, String label, IconData icon) {
    return GestureDetector(
      onTap: () => setState(() => _selected = value),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _selected == value ? AppColors.primary : AppColors.border,
            width: _selected == value ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(width: 12),
            Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
            const Spacer(),
            Radio<String>(
              value: value,
              groupValue: _selected,
              activeColor: AppColors.primary,
              onChanged: (v) => setState(() => _selected = v!),
            ),
          ],
        ),
      ),
    );
  }
}
