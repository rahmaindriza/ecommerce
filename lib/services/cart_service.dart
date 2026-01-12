import '../models/cart_model.dart';
import '../models/product_model.dart';
import 'dart:async';

class CartService {
  // List sementara untuk menyimpan Item di memory
  static final List<Item> _cartItems = [];

  // Ambil semua item di cart
  static List<Item> getCart() {
    return _cartItems;
  }

  // Tambah produk ke cart
  // Jika produk sudah ada, jumlahkan quantity
  static Future<bool> addToCart(ProductModel product, {int quantity = 1}) async {
    try {
      // Cek apakah produk sudah ada
      final index = _cartItems.indexWhere((item) => item.id == product.id.toString());
      if (index >= 0) {
        _cartItems[index].quantity += quantity;
      } else {
        _cartItems.add(
          Item(
            id: product.id.toString(),
            name: product.name,
            quantity: quantity,
            price: product.price,
          ),
        );
      }

      await Future.delayed(const Duration(milliseconds: 200));
      return true;
    } catch (e) {
      return false;
    }
  }

  // Hapus item dari cart berdasarkan item id
  static Future<bool> removeFromCart(String itemId) async {
    try {
      _cartItems.removeWhere((item) => item.id == itemId);
      await Future.delayed(const Duration(milliseconds: 200));
      return true;
    } catch (e) {
      return false;
    }
  }

  // Kosongkan cart
  static void clearCart() {
    _cartItems.clear();
  }

  // Ambil total harga
  static int getTotal() {
    return _cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }
}
