import 'package:flutter/material.dart';

class ProfileMenuSection extends StatelessWidget {
  const ProfileMenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildListTile(Icons.person_outline, 'Edit Profile'),
          _buildDivider(),
          _buildListTile(Icons.location_on_outlined, 'Shipping Address'),
          _buildDivider(),
          _buildListTile(Icons.history, 'Order History'),
          _buildDivider(),
          _buildListTile(Icons.notifications_none, 'Notifications'),
          _buildDivider(),
          _buildListTile(Icons.settings_outlined, 'Settings'),
        ],
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.black87),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {},
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, indent: 64, endIndent: 16, color: Color(0xFFEEEEEE));
  }
}
