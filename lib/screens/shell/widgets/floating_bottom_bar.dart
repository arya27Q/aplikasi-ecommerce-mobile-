import 'package:flutter/material.dart';

class FloatingBottomBar extends StatelessWidget {
  final int selectedIndex;
  final int cartItemCount;
  final ValueChanged<int> onTap;

  const FloatingBottomBar({
    super.key,
    required this.selectedIndex,
    required this.cartItemCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF111111), // Warna gelap elegan
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color(0xFF111111),
            currentIndex: selectedIndex,
            onTap: onTap,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white38,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            items: [
              const BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
              const BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Wishlist'),
              const BottomNavigationBarItem(icon: Icon(Icons.emoji_events_rounded), label: 'Leaderboard'),
              BottomNavigationBarItem(
                icon: cartItemCount > 0
                    ? Badge.count(
                        count: cartItemCount,
                        backgroundColor: const Color(0xFFD32F2F),
                        child: const Icon(Icons.shopping_bag),
                      )
                    : const Icon(Icons.shopping_bag),
                label: 'Cart',
              ),
              const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
