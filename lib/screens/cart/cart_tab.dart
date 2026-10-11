import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import 'widgets/cart_empty_view.dart';
import 'widgets/cart_item_card.dart';
import 'widgets/cart_checkout_area.dart';

class CartTab extends StatelessWidget {
  const CartTab({super.key});

  void _showClearDialog(BuildContext context, CartProvider cart) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Kosongkan Keranjang?', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Semua produk di keranjang belanja Anda akan dihapus.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Batal', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD32F2F),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              cart.clearCart();
              Navigator.of(ctx).pop();
            },
            child: const Text('Hapus Semua', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final cartItems = cart.items;
    final totalPrice = cart.totalPrice; // Derived Getter real-time

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: Text(
          'My Cart (${cart.totalItemCount})',
          style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (!cart.isEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep_outlined, color: Color(0xFFD32F2F)),
              tooltip: 'Clear Cart',
              onPressed: () => _showClearDialog(context, cart),
            ),
        ],
      ),
      body: cart.isEmpty
          ? const CartEmptyView()
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                    itemCount: cartItems.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return CartItemCard(
                        item: item,
                        onDecrement: () => cart.updateQuantity(item.id, -1),
                        onIncrement: () => cart.updateQuantity(item.id, 1),
                        onRemove: () => cart.removeItem(item.id),
                      );
                    },
                  ),
                ),
                CartCheckoutArea(
                  totalPrice: totalPrice,
                  totalItemCount: cart.totalItemCount,
                  onCheckout: () {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: const Color(0xFF111111),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        content: Text(
                          'Pesanan diproses! Total Rp ${(totalPrice / 1000).toStringAsFixed(0)}k',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }
}
