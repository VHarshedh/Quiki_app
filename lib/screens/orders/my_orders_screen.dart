import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_theme.dart';
import '../../utils/app_routes.dart';
import '../../widgets/order_card.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;

  final _activeOrders = [
    {'name': 'Strawberry Cup Cake', 'category': 'Cup Cake', 'qty': '02 pcs', 'price': '\$50.00'},
    {'name': 'Vanila Cake', 'category': 'Cake', 'qty': '01 pcs', 'price': '\$80.00'},
    {'name': 'Strawberry Cake', 'category': 'Cake', 'qty': '02 pcs', 'price': '\$88.00'},
    {'name': 'Almond Chocolate Cake', 'category': 'Cake', 'qty': '01 pcs', 'price': '\$70.00'},
    {'name': 'Chocolate Vanila', 'category': 'Cake', 'qty': '02 pcs', 'price': '\$60.00'},
  ];

  final _completedOrders = [
    {'name': 'Red Velvet', 'category': 'Cake', 'qty': '01 pcs', 'price': '\$45.00'},
    {'name': 'Blueberry Muffin', 'category': 'Cup Cake', 'qty': '03 pcs', 'price': '\$36.00'},
  ];

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
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
        title: const Text('My Orders'),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabCtrl,
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
            child: TabBarView(
              controller: _tabCtrl,
              children: [
                _buildOrderList(_activeOrders, showTrack: true),
                _buildOrderList(_completedOrders, showTrack: false),
                _buildEmptyState('No cancelled orders'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderList(List<Map<String, String>> orders, {required bool showTrack}) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (ctx, i) {
        final o = orders[i];
        return OrderCard(
          name: o['name']!,
          category: o['category']!,
          quantity: o['qty']!,
          price: o['price']!,
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
