// Blueprint (cetak biru) untuk objek Produk.
// Mendefinisikan properti apa saja yang dimiliki oleh sebuah produk sepatu.
class Product {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final double price;
  final double rating;
  final int reviews;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.description,
  });
}

// Data dummy (data statis tiruan) yang digunakan karena kita belum memiliki database/API asli.
final List<Product> dummyProducts = [
  Product(
    id: '1',
    name: 'Nike Air Max 2090',
    category: "Men's Running Shoes",
    imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&q=80&w=800',
    price: 2199000,
    rating: 4.8,
    reviews: 324,
    description: 'Menghadirkan masa lalu ke masa depan dengan Nike Air Max 2090. Terinspirasi dari DNA Air Max 90 yang ikonik, sepatu ini dilengkapi bantalan Nike Air baru di bawah kaki untuk kenyamanan tiada tara.',
  ),
  Product(
    id: '2',
    name: 'Nike Air Force 1',
    category: "Men's Sneakers",
    imageUrl: 'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?auto=format&fit=crop&q=80&w=800',
    price: 1549000,
    rating: 4.9,
    reviews: 512,
    description: 'The radiance lives on in the Nike Air Force 1 ’07, the b-ball icon that puts a fresh spin on what you know best.',
  ),
  Product(
    id: '3',
    name: 'Adidas Ultraboost 22',
    category: "Men's Running Shoes",
    imageUrl: 'https://images.unsplash.com/photo-1587563871167-1ee9c731aefb?auto=format&fit=crop&q=80&w=800',
    price: 3300000,
    rating: 4.7,
    reviews: 128,
    description: 'Say hello to incredible energy return. These running shoes have a BOOST midsole that keeps your feet feeling fresh.',
  ),
  Product(
    id: '4',
    name: 'Puma RS-X3',
    category: "Men's Lifestyle Shoes",
    imageUrl: 'https://images.unsplash.com/photo-1608231387042-66d1773070a5?auto=format&fit=crop&q=80&w=800',
    price: 1799000,
    rating: 4.6,
    reviews: 89,
    description: 'X marks extreme. Exaggerated. Remixed. The new RS-X tells a story of reinvention to the extreme.',
  ),
];
