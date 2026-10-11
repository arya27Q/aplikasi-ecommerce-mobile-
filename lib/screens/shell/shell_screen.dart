import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import 'widgets/floating_bottom_bar.dart';

class ShellScreen extends StatelessWidget {
  final Widget child;

  const ShellScreen({super.key, required this.child});

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/wishlist')) return 1;
    if (location.startsWith('/leaderboard')) return 2;
    if (location.startsWith('/cart')) return 3;
    if (location.startsWith('/profile')) return 4;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/wishlist');
        break;
      case 2:
        context.go('/leaderboard');
        break;
      case 3:
        context.go('/cart');
        break;
      case 4:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartItemCount = context.watch<CartProvider>().totalItemCount;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      extendBody: true, // Membuat body memanjang hingga ke bawah navigasi
      body: child,
      bottomNavigationBar: FloatingBottomBar(
        selectedIndex: _calculateSelectedIndex(context),
        cartItemCount: cartItemCount,
        onTap: (index) => _onItemTapped(index, context),
      ),
    );
  }
}
