import 'package:flutter/material.dart';
import '../models/cart_model.dart';

class CartDetailPage extends StatelessWidget {
  final Item item;

  CartDetailPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EEDC), // cream soft

      appBar: AppBar(
        backgroundColor: const Color(0xFFA47449), // brown elegan
        title: const Text(
          "Detail Keranjang",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 1,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ---------------- IMAGE AREA ----------------
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                color: const Color(0xFFD7B899), // light brown
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown.withOpacity(0.18),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.shopping_bag,
                size: 100,
                color: Color(0xFF4B322D),
              ),
            ),

            const SizedBox(height: 30),

            // ---------------- PRODUCT NAME ----------------
            Text(
              item.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4B322D),
              ),
            ),

            const SizedBox(height: 12),

            // ---------------- QUANTITY ----------------
            Row(
              children: [
                const Icon(Icons.shopping_cart, color: Color(0xFF4B322D)),
                const SizedBox(width: 8),
                Text(
                  "Jumlah: ${item.quantity}",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF4B322D),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // ---------------- PRICE ----------------
            Row(
              children: [
                const Icon(Icons.attach_money, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  "Rp ${item.price}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.green,
                  ),
                ),
              ],
            ),

            const Spacer(),

            // ==========================================================
            //                 BUTTON CHAT - CART - BUY
            // ==========================================================
            Row(
              children: [
                // CHAT BUTTON
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                          color: Color(0xFFA47449), width: 2),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Chat",
                      style: TextStyle(
                        color: Color(0xFFA47449),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // ADD TO CART BUTTON
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB67A4F),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Keranjang",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // BUY NOW BUTTON
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA47449), // tombol utama
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Beli Sekarang",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
