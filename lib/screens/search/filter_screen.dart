import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_theme.dart';
import '../../widgets/primary_button.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int _selectedCategory = 0;
  RangeValues _priceRange = const RangeValues(10, 40);
  int _selectedReview = 0;
  int _selectedSort = 0;
  final _categories = ['All', 'Cup Cake', 'Cookies', 'Donuts'];
  final _sortOptions = ['All', 'Popular', 'Near by', 'Price ↑'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Filter'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location
            _sectionTitle('Location'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('New York, USA', style: GoogleFonts.poppins(fontSize: 14)),
                  const Icon(Icons.keyboard_arrow_down, color: AppColors.textHint),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Category
            _sectionTitle('Category'),
            Wrap(
              spacing: 10,
              children: List.generate(_categories.length, (i) {
                final selected = i == _selectedCategory;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = i),
                  child: Chip(
                    label: Text(_categories[i]),
                    backgroundColor: selected ? AppColors.primary : AppColors.surface,
                    labelStyle: TextStyle(
                      color: selected ? AppColors.white : AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                    side: BorderSide.none,
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),

            // Price Range
            _sectionTitle('Price Range'),
            RangeSlider(
              values: _priceRange,
              min: 10,
              max: 40,
              divisions: 6,
              activeColor: AppColors.primary,
              inactiveColor: AppColors.border,
              labels: RangeLabels(
                '\$${_priceRange.start.toInt()}',
                '\$${_priceRange.end.toInt()}',
              ),
              onChanged: (v) => setState(() => _priceRange = v),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [10, 15, 20, 25, 30, 35, 40]
                  .map((v) => Text('\$$v',
                      style: TextStyle(fontSize: 11, color: AppColors.textSecondary)))
                  .toList(),
            ),
            const SizedBox(height: 24),

            // Reviews
            _sectionTitle('Reviews'),
            ...List.generate(5, (i) {
              final labels = [
                '4.5 and above', '4.0 - 4.5', '3.5 - 4.0', '3.0 - 3.5', '2.5 - 3.0'
              ];
              return GestureDetector(
                onTap: () => setState(() => _selectedReview = i),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      ...List.generate(5, (s) => Icon(
                        Icons.star,
                        size: 18,
                        color: s < (5 - i) ? AppColors.star : AppColors.border,
                      )),
                      const SizedBox(width: 12),
                      Text(labels[i], style: const TextStyle(fontSize: 13)),
                      const Spacer(),
                      Radio<int>(
                        value: i,
                        groupValue: _selectedReview,
                        activeColor: AppColors.primary,
                        onChanged: (v) => setState(() => _selectedReview = v!),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 16),

            // Sort
            _sectionTitle('Sortby'),
            Wrap(
              spacing: 10,
              children: List.generate(_sortOptions.length, (i) {
                final selected = i == _selectedSort;
                return GestureDetector(
                  onTap: () => setState(() => _selectedSort = i),
                  child: Chip(
                    label: Text(_sortOptions[i]),
                    backgroundColor: selected ? AppColors.primary : AppColors.surface,
                    labelStyle: TextStyle(
                      color: selected ? AppColors.white : AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                    side: BorderSide.none,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: PrimaryButton(
                text: 'Reset Filter',
                isOutlined: true,
                onPressed: () {
                  setState(() {
                    _selectedCategory = 0;
                    _priceRange = const RangeValues(10, 40);
                    _selectedReview = 0;
                    _selectedSort = 0;
                  });
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: PrimaryButton(
                text: 'Apply',
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(text,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
    );
  }
}
