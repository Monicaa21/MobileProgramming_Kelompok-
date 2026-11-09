import 'package:flutter/material.dart';
import '../../domain/product.dart';
 
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