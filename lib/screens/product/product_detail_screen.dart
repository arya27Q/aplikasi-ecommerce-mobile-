import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import 'widgets/size_variant_selector.dart';
import 'widgets/product_detail_bottom_bar.dart';

// Halaman yang menampilkan informasi detail produk sepatu ketika salah satu item di-klik.
class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  // State untuk varian ukuran sepatu yang dipilih
  String _selectedSize = '42';
  final List<String> _availableSizes = ['40', '41', '42', '43', '44'];

  void _addToCart() {
    // 1. Simpan ke CartProvider secara global
    final cart = context.read<CartProvider>();
    cart.addItem(widget.product, _selectedSize);

    // 2. Berikan feedback interaktif kepada pengguna yang otomatis hilang dalam ~1.8 detik
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF111111),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(milliseconds: 1800),
        dismissDirection: DismissDirection.horizontal,
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.greenAccent, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Ditambahkan ke Keranjang (Size $_selectedSize)',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
          ],
        ),
        action: SnackBarAction(
          label: 'Lihat Cart',
          textColor: Colors.amberAccent,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            if (mounted) {
              context.go('/cart');
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final product = widget.product;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // KONTEN YANG BISA DI-SCROLL (Gambar + Detail)
          SingleChildScrollView(
            child: Stack(
              children: [
                // 1. AREA GAMBAR SEPATU
                Hero(
                  tag: product.id,
                  child: Container(
                    width: double.infinity,
                    height: screenHeight * 0.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(product.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                // 2. KONTEN DETAIL PRODUK
                Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.42),
                  padding: const EdgeInsets.all(24.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Label Kategori
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFEBEE),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          product.category,
                          style: const TextStyle(
                            color: Color(0xFFD32F2F),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Nama Produk & Harga
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w900,
                                height: 1.2,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'Rp ${(product.price / 1000).toStringAsFixed(0)}k',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFFD32F2F),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Rating & Terjual
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            product.rating.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '(${product.reviews} Reviews)',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Deskripsi Produk
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.description,
                        style: const TextStyle(
                          color: Colors.black54,
                          height: 1.5,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Pilihan Ukuran (Sub-widget Modular)
                      SizeVariantSelector(
                        availableSizes: _availableSizes,
                        selectedSize: _selectedSize,
                        onSizeSelected: (size) {
                          setState(() {
                            _selectedSize = size;
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 3. APP BAR TRANSPARAN FLOATING
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white.withValues(alpha: 0.9),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        context.pop();
                      },
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white.withValues(alpha: 0.9),
                    child: IconButton(
                      icon: const Icon(
                        Icons.favorite,
                        color: Color(0xFFD32F2F),
                      ),
                      onPressed: () {
                        context.pop('favorited');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // 4. BOTTOM ACTION BAR (Sub-widget Modular)
      bottomNavigationBar: ProductDetailBottomBar(
        price: product.price,
        onAddToCart: _addToCart,
      ),
    );
  }
}
