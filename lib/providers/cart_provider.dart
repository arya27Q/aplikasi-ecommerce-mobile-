import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  // Getter list items tidak dapat dimodifikasi langsung dari luar (unmodifiable)
  List<CartItem> get items => List.unmodifiable(_items);

  // Derived Getter: Menghitung total harga belanjaan secara real-time
  double get totalPrice {
    return _items.fold(0.0, (sum, item) => sum + item.subtotal);
  }

  // Derived Getter: Menghitung total item / kuantitas keseluruhan
  int get totalItemCount {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }

  // Derived Getter: Menghitung jumlah jenis produk unik di cart
  int get uniqueItemCount => _items.length;

  // Check apakah keranjang belanja kosong
  bool get isEmpty => _items.isEmpty;

  // 1. Requirement: Add item dengan penanganan varian (misal ukuran)
  void addItem(Product product, String variant) {
    // Cek apakah item dengan ID produk DAN varian yang sama sudah ada di keranjang
    final existingIndex = _items.indexWhere(
      (item) => item.product.id == product.id && item.selectedVariant == variant,
    );

    if (existingIndex >= 0) {
      // Jika kombinasi produk & varian sama sudah ada, cukup tambahkan kuantitasnya
      _items[existingIndex].quantity += 1;
    } else {
      // Jika belum ada / varian berbeda, buat CartItem baru
      _items.add(
        CartItem(
          id: '${product.id}_${variant}_${DateTime.now().millisecondsSinceEpoch}',
          product: product,
          selectedVariant: variant,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  // Tambah / kurangi kuantitas item
  void updateQuantity(String cartItemId, int delta) {
    final index = _items.indexWhere((item) => item.id == cartItemId);
    if (index >= 0) {
      final newQuantity = _items[index].quantity + delta;
      if (newQuantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = newQuantity;
      }
      notifyListeners();
    }
  }

  // 2. Requirement: Remove item spesifik
  void removeItem(String cartItemId) {
    _items.removeWhere((item) => item.id == cartItemId);
    notifyListeners();
  }

  // 2. Requirement: Clear seluruh item di keranjang
  void clearCart() {
    if (_items.isNotEmpty) {
      _items.clear();
      notifyListeners();
    }
  }
}
