import 'package:flutter/material.dart';
import '../../models/product.dart';
import 'widgets/wishlist_item_card.dart';

class WishlistTab extends StatelessWidget {
  const WishlistTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil beberapa produk dummy sebagai contoh wishlist
    final wishlist = [dummyProducts[1], dummyProducts[3]];

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text('My Wishlist', style: TextStyle(fontWeight: FontWeight.w900)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 120),
        itemCount: wishlist.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final product = wishlist[index];
          return WishlistItemCard(
            product: product,
            onFavoriteTap: () {},
          );
        },
      ),
    );
  }
}
