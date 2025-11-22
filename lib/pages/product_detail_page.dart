import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/cart_service.dart';
import '../services/review_service.dart';
import 'add_review_page.dart';

// NEW
import 'review_list_page.dart';
import 'review_detail_page.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel product;

  ProductDetailPage({required this.product});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  List<dynamic> reviews = [];
  bool loadingReviews = true;

  @override
  void initState() {
    super.initState();
    loadReviews();
  }

  Future<void> loadReviews() async {
    final data =
    await ReviewService().getReviewByProduct(widget.product.id);
    setState(() {
      reviews = data;
      loadingReviews = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EEDC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFA47449),
        title: Text(
          widget.product.name,
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // --------------------
              // CARD PRODUK
              // --------------------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3E4C8),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.brown.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD7B899),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.shopping_bag,
                          size: 80, color: Color(0xFF4B322D)),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.product.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4B322D),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Rp ${widget.product.price}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // DESKRIPSI
              const Text(
                "Deskripsi",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4B322D),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.product.deskripsion,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF4B322D),
                ),
              ),

              const SizedBox(height: 25),

              // --------------------
              // LIST REVIEW
              // --------------------
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Review Produk",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4B322D),
                    ),
                  ),

                  const SizedBox(width: 10), // jarak kecil

                  // Tombol Lihat Semua + Tambah
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ReviewListPage(
                                    productId: widget.product.id,
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              "Lihat Semua",
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        Flexible(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFA47449),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                            ),
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      AddReviewPage(productId: widget.product.id),
                                ),
                              );
                              if (result == true) {
                                loadReviews(); // refresh
                              }
                            },
                            child: const Text(
                              "Tambah",
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),

              const SizedBox(height: 10),

              loadingReviews
                  ? const Center(child: CircularProgressIndicator())
                  : reviews.isEmpty
                  ? const Text("Belum ada review.")
                  : Column(
                children: reviews.take(3).map((r) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ReviewDetailPage(
                            review: r,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "⭐ ${r['rating']}",
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text(r["review"]),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 30),

              // --------------------
              // BUTTON BAWAH
              // --------------------
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.shopping_cart),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFA47449),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      label: const Text(
                        "Keranjang",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        bool ok =
                        await CartService().addToCart(widget.product.id);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: ok ? Colors.green : Colors.red,
                            content: Text(ok
                                ? "Berhasil ditambahkan ke keranjang!"
                                : "Gagal menambah"),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Beli Sekarang",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
