import 'package:flutter/material.dart';
import '../models/cart_model.dart';
import '../services/cart_service.dart';
import 'cart_detail_page.dart';

class CartListPage extends StatefulWidget {
  const CartListPage({super.key});

  @override
  State<CartListPage> createState() => _CartListPageState();
}

class _CartListPageState extends State<CartListPage> {
  bool loading = true;
  CartModel? cart;

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  Future<void> loadCart() async {
    setState(() => loading = true);
    cart = CartModel(items: CartService.getCart());
    setState(() => loading = false);
  }

  Future<void> deleteItem(String productId) async {
    await CartService.removeFromCart(productId);
    loadCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EEDC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFA47449),
        title: const Text(
          "Keranjang",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : cart == null || cart!.items.isEmpty
          ? const Center(
        child: Text(
          "Keranjang kosong",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xFF4B322D),
          ),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cart!.items.length,
        itemBuilder: (_, i) {
          final item = cart!.items[i];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CartDetailPage(item: item),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF3E4C8),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown.withOpacity(0.18),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // ICON PRODUK
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD7B899),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.shopping_bag,
                      size: 40,
                      color: Color(0xFF4B322D),
                    ),
                  ),
                  const SizedBox(width: 14),

                  // DETAIL ITEM
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4B322D),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Qty: ${item.quantity}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF4B322D),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Rp ${item.price}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // DELETE BUTTON
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteItem(item.id),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      // FOOTER TOTAL HARGA
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color(0xFFF3E4C8),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, -2),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Total:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4B322D),
              ),
            ),
            Text(
              "Rp ${cart?.total ?? 0}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4B322D),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
