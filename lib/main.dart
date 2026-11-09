import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko E-Commerce',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true, colorSchemeSeed: Colors.red),
      home: const HomePage(),
    );
  }
}

// struktur data produk
class Product {
  final String name;
  final int price;
  const Product(this.name, this.price);
}
 
// daftar produknya 
// <Product> itu objectnya
const List<Product> allProducts = [
  Product('Buku tulis', 12900),
  Product('Tas Wanita', 269000),
  Product('Tas Ransel Laptop', 275000),
  Product('Headphone Bluetooth', 299000),
  Product('Stanley Tumblr', 850000),
  Product('Kaos SpiderMan', 59000),
];
 
class HomePage extends StatefulWidget {
  const HomePage({super.key});
 
  @override
  State<HomePage> createState() => _HomePageState();
}
 
class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  int _cartCount = 0;
 
  // buat bersihin resource kalau misal halamannya udh ga di homepage
  @override
  void dispose() {
    // kalo udh dihalaman yang bukan homepage, searchControllernya dibersihin
    _searchController.dispose();
    super.dispose();
  }
 
  // cari produk berdasarkan pencarian
  List<Product> get _filteredProducts => allProducts
      .where((p) => p.name.toLowerCase().contains(_query.toLowerCase()))
      .toList();
 
  // produk mengambil daftar produk yang sudah difilter.
  @override
  Widget build(BuildContext context) {
    final products = _filteredProducts;
 
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        title: _buildSearchBar(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              tooltip: 'Keranjang',
              icon: Badge(
                isLabelVisible: _cartCount > 0,
                label: Text('$_cartCount'),
                child: const Icon(Icons.shopping_cart_outlined),
              ),
              onPressed: () {
                // TODO: navigasi ke halaman keranjang
              },
            ),
          ),
        ],
      ),

      // tampilin produk di halamannya
      // periksa apakah produk masih ada
      body: products.isEmpty
          ? const Center(child: Text('Produk tidak ditemukan'))
          // kalau produknya ada, tampilin
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              // jika terdapat 6 produk, maka itemCount bernilai 6.
              itemCount: products.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              // Menentukan tampilan setiap produk
              itemBuilder: (context, i) {
                final p = products[i];
                // struktur card produknya
                return Card(
                  child: ListTile(
                    title: Text(p.name),
                    subtitle: Text('Rp ${p.price}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.add_shopping_cart),
                      onPressed: () => setState(() => _cartCount++),
                    ),
                  ),
                );
              },
            ),
    );
  }
 
  Widget _buildSearchBar() {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: _searchController,
        onChanged: (value) => setState(() => _query = value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Cari produk...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _query.isEmpty
              ? null
              : IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _query = '');
                  },
                ),
          filled: true,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}