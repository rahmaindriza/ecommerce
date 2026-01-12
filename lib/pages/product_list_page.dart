import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';
import 'product_detail_page.dart';
import 'add_product_page.dart';
import 'cart_list_page.dart';

class ProductListPage extends StatefulWidget {
  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  bool loading = true;
  List<ProductModel> products = [];

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  // ================= LOAD DATA =================
  Future<void> loadProducts() async {
    setState(() => loading = true);
    try {
      products = await ProductService.getProducts();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
    setState(() => loading = false);
  }

  // ================= DELETE =================
  Future<void> deleteProduct(int id) async {
    await ProductService.deleteProduct(id);
    loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EEDC),

      // ================= APPBAR =================
      appBar: AppBar(
        backgroundColor: const Color(0xFFA47449),
        title: const Text(
          "List Produk",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CartListPage()),
              );
            },
          )
        ],
      ),

      // ================= ADD BUTTON (FIXED) =================
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFA47449),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddProductPage()),
          );

          if (result == true) {
            loadProducts();
          }
        },
      ),

      // ================= BODY =================
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : products.isEmpty
          ? const Center(child: Text("Data produk kosong"))
          : Padding(
        padding: const EdgeInsets.all(12),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (_, i) {
            final p = products[i];

            return InkWell(
              borderRadius: BorderRadius.circular(16),

              // 👆 1 KLIK = DETAIL (READ ONLY)
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailPage(
                      product: p,
                      readOnly: true,
                    ),
                  ),
                );
              },

              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3E4C8),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.brown.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    // ===== ICON =====
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD7B899),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                        ),
                      ),
                      child: const Icon(
                        Icons.shopping_bag,
                        size: 40,
                        color: Color(0xFF4B322D),
                      ),
                    ),

                    // ===== INFO =====
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              p.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4B322D),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Rp ${p.price}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              p.description ?? "-",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF6F4E37),
                              ),
                            ),
                            const SizedBox(height: 10),

                            // ===== ACTION =====
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () async {
                                    final result =
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            ProductDetailPage(
                                              product: p,
                                            ),
                                      ),
                                    );

                                    if (result == true) {
                                      loadProducts();
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    deleteProduct(p.id);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
