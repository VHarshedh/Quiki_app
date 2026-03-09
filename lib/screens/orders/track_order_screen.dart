import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_theme.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Track Order'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Order Item
            Container(
              padding: const EdgeInsets.all(14),
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
                    width: 56, height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.cake, color: AppColors.primaryLight, size: 28),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Strawberry Cup Cake',
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                        Text('Cup Cake | Qty : 02 pcs',
                            style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                  Text('\$50.00',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Tracking Stepper
            ..._buildTrackingSteps(),

            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 16),

            // Driver Info
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.surface,
                  child: const Icon(Icons.person, color: AppColors.primaryLight),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Sadek Ebubekir',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                      Text('Delivery Man',
                          style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.phone, color: AppColors.primary, size: 20),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.message, color: AppColors.primary, size: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTrackingSteps() {
    final steps = [
      {'title': 'Order Placed', 'time': 'Feb 28, 10:00 AM', 'status': 'completed'},
      {'title': 'Order Confirmed', 'time': 'Feb 28, 10:05 AM', 'status': 'completed'},
      {'title': 'Order Shipped', 'time': 'Feb 28, 11:30 AM', 'status': 'current'},
      {'title': 'Out for Delivery', 'time': 'Pending', 'status': 'pending'},
      {'title': 'Order Delivered', 'time': 'Pending', 'status': 'pending'},
    ];

    return List.generate(steps.length, (i) {
      final step = steps[i];
      final isCompleted = step['status'] == 'completed';
      final isCurrent = step['status'] == 'current';
      final isLast = i == steps.length - 1;

      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: isCompleted || isCurrent
                      ? AppColors.primary
                      : AppColors.border,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isCompleted
                      ? Icons.check
                      : isCurrent
                          ? Icons.local_shipping
                          : Icons.circle,
                  size: isCompleted || isCurrent ? 16 : 8,
                  color: isCompleted || isCurrent
                      ? AppColors.white
                      : AppColors.textHint,
                ),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 40,
                  color: isCompleted ? AppColors.primary : AppColors.border,
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(step['title']!,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: isCompleted || isCurrent
                            ? AppColors.textPrimary
                            : AppColors.textHint,
                      )),
                  Text(step['time']!,
                      style: TextStyle(
                          fontSize: 12, color: AppColors.textSecondary)),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
