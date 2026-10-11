import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../auth/auth_notifier.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_menu_section.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text('My Profile', style: TextStyle(fontWeight: FontWeight.w900)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            // AVATAR & INFO (Sub-widget)
            const ProfileHeader(),
            const SizedBox(height: 32),
            
            // MENU OPTIONS (Sub-widget)
            const ProfileMenuSection(),
            const SizedBox(height: 24),

            // LOGOUT BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.read<AuthNotifier>().logout();
                  },
                  icon: const Icon(Icons.logout, color: Color(0xFFD32F2F)),
                  label: const Text(
                    'Log Out',
                    style: TextStyle(
                      color: Color(0xFFD32F2F),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFEBEE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 120), // Memberi ruang aman dari floating bottom nav
          ],
        ),
      ),
    );
  }
}
