import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_theme.dart';
import '../../widgets/primary_button.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  bool _saveCard = true;
  final _holderCtrl = TextEditingController(text: 'Esther Howard');
  final _numberCtrl = TextEditingController(text: '4716 9627 1635 8047');
  final _expiryCtrl = TextEditingController(text: '02/30');
  final _cvvCtrl = TextEditingController(text: '000');

  @override
  void dispose() {
    _holderCtrl.dispose();
    _numberCtrl.dispose();
    _expiryCtrl.dispose();
    _cvvCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Add Card'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Visual Card Preview
            Container(
              width: double.infinity,
              height: 200,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF8B4513), Color(0xFFA0522D), Color(0xFF6B3410)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.credit_card, color: AppColors.white, size: 32),
                      Text('VISA',
                          style: GoogleFonts.poppins(
                              color: AppColors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                  const Spacer(),
                  Text(_numberCtrl.text,
                      style: GoogleFonts.poppins(
                          color: AppColors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Card holder name',
                              style: TextStyle(
                                  color: AppColors.white.withValues(alpha: 0.7), fontSize: 10)),
                          Text(_holderCtrl.text,
                              style: const TextStyle(
                                  color: AppColors.white, fontSize: 13, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Expiry date',
                              style: TextStyle(
                                  color: AppColors.white.withValues(alpha: 0.7), fontSize: 10)),
                          Text(_expiryCtrl.text,
                              style: const TextStyle(
                                  color: AppColors.white, fontSize: 13, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Form
            _buildLabel('Card Holder Name'),
            TextField(controller: _holderCtrl, onChanged: (_) => setState(() {})),
            const SizedBox(height: 16),

            _buildLabel('Card Number'),
            TextField(
              controller: _numberCtrl,
              keyboardType: TextInputType.number,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('Expiry Date'),
                      TextField(controller: _expiryCtrl, onChanged: (_) => setState(() {})),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('CVV'),
                      TextField(
                        controller: _cvvCtrl,
                        obscureText: true,
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Checkbox(
                  value: _saveCard,
                  activeColor: AppColors.primary,
                  onChanged: (v) => setState(() => _saveCard = v!),
                ),
                Text('Save Card', style: GoogleFonts.poppins(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 24),

            PrimaryButton(
              text: 'Add Card',
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text,
          style: GoogleFonts.poppins(
              fontSize: 13,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500)),
    );
  }
}
