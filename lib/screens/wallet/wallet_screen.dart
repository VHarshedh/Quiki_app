import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../utils/app_theme.dart';
import '../../utils/app_routes.dart';
import '../../widgets/primary_button.dart';
import '../../features/wallet/presentation/providers/wallet_provider.dart';
import '../../auth/presentation/providers/auth_provider.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final walletProvider = context.watch<WalletProvider>();

    // Start listening if authenticated
    if (authProvider.isAuthenticated) {
      walletProvider.listenToWallet(authProvider.user.id);
    }

    if (!authProvider.isAuthenticated) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.account_balance_wallet_outlined,
                    size: 64, color: AppColors.textHint),
                const SizedBox(height: 16),
                Text('Please login to view your wallet',
                    style: TextStyle(color: AppColors.textSecondary)),
                const SizedBox(height: 16),
                PrimaryButton(
                  text: 'Login',
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.login, (r) => false),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Text('My Wallet',
                  style: GoogleFonts.poppins(
                      fontSize: 22, fontWeight: FontWeight.w700)),
            ),
            const SizedBox(height: 20),

            // Balance Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF8B4513),
                      Color(0xFFA0522D),
                      Color(0xFF6B3410),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Balance',
                        style: GoogleFonts.poppins(
                          color: AppColors.white.withValues(alpha: 0.7),
                          fontSize: 14,
                        )),
                    const SizedBox(height: 8),
                    Text(
                        '\$${walletProvider.balance.toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(
                          color: AppColors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                        )),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text('Add Money',
                            style: GoogleFonts.poppins(
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Transaction History
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('Transaction History',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: walletProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : walletProvider.transactions.isEmpty
                      ? Center(
                          child: Text('No transactions yet',
                              style: TextStyle(color: AppColors.textSecondary)),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: walletProvider.transactions.length,
                          itemBuilder: (ctx, i) {
                            final t = walletProvider.transactions[i];
                            final amount =
                                (t['amount'] as num?)?.toDouble() ?? 0.0;
                            final isCredit =
                                (t['type'] ?? '') == 'credit' || amount > 0;
                            final displayAmount = isCredit
                                ? '+\$${amount.abs().toStringAsFixed(2)}'
                                : '-\$${amount.abs().toStringAsFixed(2)}';
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Colors.black.withValues(alpha: 0.04),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: (isCredit
                                              ? AppColors.success
                                              : AppColors.primary)
                                          .withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      isCredit
                                          ? Icons.add_circle_outline
                                          : Icons.cake,
                                      color: isCredit
                                          ? AppColors.success
                                          : AppColors.primary,
                                      size: 22,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(t['name'] ?? '',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14)),
                                        Text(t['date'] ?? '',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color:
                                                    AppColors.textSecondary)),
                                      ],
                                    ),
                                  ),
                                  Text(displayAmount,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: isCredit
                                            ? AppColors.success
                                            : AppColors.textPrimary,
                                      )),
                                  const SizedBox(width: 8),
                                  Icon(
                                    Icons.check_circle,
                                    size: 18,
                                    color: AppColors.success,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
