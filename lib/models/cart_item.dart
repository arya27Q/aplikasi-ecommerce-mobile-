import 'product.dart';

class CartItem {
  final String id;
  final Product product;
  final String selectedVariant; // e.g. Ukuran sepatu: '40', '41', '42'
  int quantity;

  CartItem({
    required this.id,
    required this.product,
    required this.selectedVariant,
    this.quantity = 1,
  });

  double get subtotal => product.price * quantity;
}
