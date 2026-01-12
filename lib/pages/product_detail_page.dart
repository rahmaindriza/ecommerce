import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';
import '../services/cart_service.dart';
import 'cart_list_page.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel? product;
  final bool readOnly; // true = detail, false = edit

  const ProductDetailPage({
    super.key,
    this.product,
    this.readOnly = false,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final nameCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      nameCtrl.text = widget.product!.name;
      priceCtrl.text = widget.product!.price.toString();
      descCtrl.text = widget.product!.description ?? '';
    }
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    priceCtrl.dispose();
    descCtrl.dispose();
    super.dispose();
  }

  // ================= SAVE EDIT =================
  Future<void> save() async {
    if (nameCtrl.text.isEmpty || priceCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama dan harga wajib diisi')),
      );
      return;
    }

    final data = {
      'name': nameCtrl.text,
      'price': int.parse(priceCtrl.text),
      'description': descCtrl.text.isEmpty ? null : descCtrl.text,
    };

    await ProductService.updateProduct(widget.product!.id, data);
    Navigator.pop(context, true);
  }

  // ================= ADD TO CART =================
  Future<void> addToCart() async {
    if (widget.product == null) return;

    final success = await CartService.addToCart(widget.product!);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success
            ? 'Produk berhasil ditambahkan ke keranjang'
            : 'Gagal menambahkan produk ke keranjang'),
      ),
    );
  }

  // ================= BUY NOW =================
  void buyNow() {
    if (widget.product == null) return;

    Navigator.pushNamed(context, '/checkout', arguments: widget.product);
  }

  @override
  Widget build(BuildContext context) {
    final isDetail = widget.readOnly;
    final isEdit = widget.product != null && !isDetail;

    return Scaffold(
      backgroundColor: const Color(0xFFF8EEDC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFA47449),
        title: Text(
          isDetail
              ? 'Detail Produk'
              : (isEdit ? 'Edit Produk' : 'Tambah Produk'),
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          if (isDetail)
            IconButton(
              icon: const Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CartListPage()),
                );
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameCtrl,
              readOnly: isDetail,
              decoration: const InputDecoration(
                labelText: 'Nama Produk',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: priceCtrl,
              readOnly: isDetail,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Harga',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descCtrl,
              readOnly: isDetail,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Deskripsi',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            // ===== BUTTONS =====
            if (!isDetail)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA47449),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: save,
                child: const Text(
                  'Update Produk',
                  style: TextStyle(color: Colors.white),
                ),
              ),

            if (isDetail && widget.product != null)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: addToCart,
                      icon: const Icon(Icons.add_shopping_cart),
                      label: const Text("Keranjang"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFA47449),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: buyNow,
                      icon: const Icon(Icons.flash_on),
                      label: const Text("Beli Sekarang"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}