import 'package:flutter/material.dart';
import '../services/product_service.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final nameCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  Future<void> saveProduct() async {
    // ===== VALIDASI =====
    if (nameCtrl.text.isEmpty || priceCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama & harga wajib diisi')),
      );
      return;
    }

    try {
      await ProductService.addProduct({
        "name": nameCtrl.text,
        "price": int.parse(priceCtrl.text), // ✅ FIX
        "description":
        descCtrl.text.isEmpty ? null : descCtrl.text,
      });

      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan produk: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EEDC),
      appBar: AppBar(
        title: const Text("Tambah Produk"),
        backgroundColor: const Color(0xFFA47449),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: "Nama Produk",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: priceCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Harga",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: descCtrl,
              decoration: const InputDecoration(
                labelText: "Deskripsi",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA47449),
                  padding:
                  const EdgeInsets.symmetric(vertical: 14),
                ),
                icon: const Icon(Icons.save, color: Colors.white),
                label: const Text(
                  "Simpan Produk",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: saveProduct,
              ),
            )
          ],
        ),
      ),
    );
  }
}
