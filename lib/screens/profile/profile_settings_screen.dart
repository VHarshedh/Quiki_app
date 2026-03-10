import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../utils/app_theme.dart';
import '../../utils/app_routes.dart';
import '../../widgets/primary_button.dart';
import '../../auth/presentation/providers/auth_provider.dart';
import '../../features/profile/presentation/providers/profile_provider.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final isGuest = !authProvider.isAuthenticated;

    if (isGuest) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_outline, size: 80, color: AppColors.textHint),
                const SizedBox(height: 16),
                Text(
                  'Guest Profile',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please login or sign up to view your profile, orders, and settings.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                  text: 'Login / Sign Up',
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.login, (route) => false);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Load profile data
    final profileProvider = context.watch<ProfileProvider>();
    if (profileProvider.profileData == null && !profileProvider.isLoading) {
      profileProvider.loadProfile(authProvider.user.id);
    }

    final menuItems = [
      {'icon': Icons.person_outline, 'label': 'Personal Info', 'route': AppRoutes.editProfile},
      {'icon': Icons.local_shipping_outlined, 'label': 'Track Order', 'route': AppRoutes.trackOrder},
      {'icon': Icons.location_on_outlined, 'label': 'My Address', 'route': AppRoutes.shippingAddress},
      {'icon': Icons.payment_outlined, 'label': 'Payment Method', 'route': AppRoutes.paymentMethod},
      {'icon': Icons.favorite_outline, 'label': 'My Wishlist', 'route': ''},
      {'icon': Icons.notifications_outlined, 'label': 'Notification', 'route': ''},
      {'icon': Icons.security_outlined, 'label': 'Security', 'route': AppRoutes.setPassword},
      {'icon': Icons.logout, 'label': 'Logout', 'route': AppRoutes.login},
    ];

    final displayName = profileProvider.name.isNotEmpty
        ? profileProvider.name
        : authProvider.user.name ?? 'My Account';
    final displayEmail = profileProvider.email.isNotEmpty
        ? profileProvider.email
        : authProvider.user.email;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Text('My Profile',
                style: GoogleFonts.poppins(
                    fontSize: 22, fontWeight: FontWeight.w700)),
            const SizedBox(height: 24),

            // Avatar
            CircleAvatar(
              radius: 44,
              backgroundColor: AppColors.surface,
              child: Icon(Icons.person, size: 44, color: AppColors.primaryLight),
            ),
            const SizedBox(height: 12),
            Text(displayName,
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(displayEmail,
                style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
            const SizedBox(height: 24),

            // Menu
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: menuItems.length,
                separatorBuilder: (context, index) => const SizedBox(height: 4),
                itemBuilder: (ctx, i) {
                  final item = menuItems[i];
                  final isLogout = item['label'] == 'Logout';
                  return ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isLogout
                            ? AppColors.error.withValues(alpha: 0.1)
                            : AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        item['icon'] as IconData,
                        color: isLogout ? AppColors.error : AppColors.primary,
                        size: 22,
                      ),
                    ),
                    title: Text(
                      item['label'] as String,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: isLogout ? AppColors.error : AppColors.textPrimary,
                      ),
                    ),
                    trailing: Icon(Icons.chevron_right,
                        color: AppColors.textHint, size: 22),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    onTap: () {
                      final route = item['route'] as String;
                      if (route.isNotEmpty) {
                        if (isLogout) {
                          authProvider.signOut();
                          Navigator.pushNamedAndRemoveUntil(
                              context, route, (r) => false);
                        } else {
                          Navigator.pushNamed(context, route);
                        }
                      }
                    },
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
