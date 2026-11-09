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