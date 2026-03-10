import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../utils/app_theme.dart';
import '../../widgets/primary_button.dart';
import '../../auth/presentation/providers/auth_provider.dart';
import '../../features/profile/presentation/providers/profile_provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _initialized = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final profileProvider = context.watch<ProfileProvider>();

    // Initialize controllers with existing data once
    if (!_initialized && profileProvider.profileData != null) {
      _nameController.text = profileProvider.name;
      _emailController.text = profileProvider.email.isNotEmpty
          ? profileProvider.email
          : authProvider.user.email;
      _phoneController.text = profileProvider.phone;
      _initialized = true;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Edit Profile'),
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
            _buildField('Name', _nameController),
            _buildField('Email', _emailController, enabled: false),
            _buildField('Phone', _phoneController),
            const SizedBox(height: 30),
            Consumer<ProfileProvider>(
              builder: (context, provider, _) {
                return PrimaryButton(
                  text: provider.isLoading ? 'Saving...' : 'Save',
                  onPressed: provider.isLoading
                      ? null
                      : () async {
                          final success = await profileProvider.updateProfile(
                            authProvider.user.id,
                            {
                              'name': _nameController.text.trim(),
                              'phone': _phoneController.text.trim(),
                            },
                          );
                          if (!context.mounted) return;
                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Profile updated!')),
                            );
                            Navigator.pop(context);
                          }
                        },
                );
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller,
      {bool enabled = true}) {
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
            controller: controller,
            enabled: enabled,
            decoration: InputDecoration(
              fillColor: enabled ? null : AppColors.surface,
            ),
          ),
        ],
      ),
    );
  }
}
