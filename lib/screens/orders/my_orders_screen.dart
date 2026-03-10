import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../utils/app_theme.dart';
import '../../utils/app_routes.dart';
import '../../widgets/order_card.dart';
import '../../features/orders/presentation/providers/orders_provider.dart';
import '../../auth/presentation/providers/auth_provider.dart';
import '../../widgets/primary_button.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final ordersProvider = context.watch<OrdersProvider>();

    // Start listening if authenticated
    if (authProvider.isAuthenticated) {
      ordersProvider.listenToOrders(authProvider.user.id);
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('My Orders'),
        ),
        body: !authProvider.isAuthenticated
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.receipt_long_outlined, size: 64, color: AppColors.textHint),
                    const SizedBox(height: 16),
                    Text('Please login to view your orders',
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
            : Column(
                children: [
                  TabBar(
                    labelColor: AppColors.primary,
                    unselectedLabelColor: AppColors.textSecondary,
                    indicatorColor: AppColors.primary,
                    indicatorWeight: 2.5,
                    labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    tabs: const [
                      Tab(text: 'Active'),
                      Tab(text: 'Completed'),
                      Tab(text: 'Cancelled'),
                    ],
                  ),
                  Expanded(
                    child: ordersProvider.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : TabBarView(
                            children: [
                              _buildOrderList(context, ordersProvider.activeOrders,
                                  showTrack: true),
                              _buildOrderList(
                                  context, ordersProvider.completedOrders,
                                  showTrack: false),
                              _buildOrderList(
                                  context, ordersProvider.cancelledOrders,
                                  showTrack: false),
                            ],
                          ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildOrderList(
      BuildContext context, List<Map<String, dynamic>> orders,
      {required bool showTrack}) {
    if (orders.isEmpty) {
      return _buildEmptyState('No orders');
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (ctx, i) {
        final o = orders[i];
        final items = o['items'] as List<dynamic>? ?? [];
        final firstItem = items.isNotEmpty ? items[0] as Map<String, dynamic> : {};
        return OrderCard(
          name: firstItem['name'] ?? 'Order #${o['id']?.toString().substring(0, 6) ?? ''}',
          category: '${items.length} item${items.length != 1 ? 's' : ''}',
          quantity: '\$${(o['totalAmount'] as num?)?.toStringAsFixed(2) ?? '0.00'}',
          price: '',
          buttonText: showTrack ? 'Track Order' : null,
          onButtonPressed: showTrack
              ? () => Navigator.pushNamed(context, AppRoutes.trackOrder)
              : null,
        );
      },
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 64, color: AppColors.textHint),
          const SizedBox(height: 16),
          Text(message,
              style: TextStyle(fontSize: 16, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
