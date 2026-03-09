import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_theme.dart';
import '../../widgets/primary_button.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Profile'),
        actions: [
          IconButton(icon: const Icon(Icons.calendar_today_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.emoji_emotions_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.settings_outlined), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.surface,
                  child: Icon(Icons.person, size: 50, color: AppColors.primaryLight),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 2),
                    ),
                    child: const Icon(Icons.edit, size: 16, color: AppColors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            _buildField('Username', 'Sana Nassani'),
            _buildField('Email', 'sananassani@gmail.com'),
            _buildField('Password', '••••••••', isPassword: true),
            _buildDropdownField('Gender', 'Female'),
            _buildField('Date of Birth', '01/01/1990'),
            const SizedBox(height: 30),
            PrimaryButton(text: 'Save', onPressed: () => Navigator.pop(context)),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, String value, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: TextEditingController(text: value),
            obscureText: isPassword,
            decoration: InputDecoration(
              suffixIcon: isPassword
                  ? const Icon(Icons.visibility_off_outlined,
                      color: AppColors.textHint)
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value, style: GoogleFonts.poppins(fontSize: 14)),
                const Icon(Icons.keyboard_arrow_down, color: AppColors.textHint),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
