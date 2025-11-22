import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cart_model.dart';

class CartService {
  final baseUrl = "http://192.168.18.238:8000";

  Future<Model> getCart() async {
    final url = Uri.parse("$baseUrl/carts");
    final res = await http.get(url);

    if (res.statusCode == 200) {
      return modelFromJson(res.body);
    }
    throw Exception("Gagal load cart");
  }

  Future<bool> deleteItem(int id) async {
    final url = Uri.parse("$baseUrl/carts/$id");
    final res = await http.delete(url);

    return res.statusCode == 200;
  }

  Future<bool> addToCart(int productId) async {
    final url = Uri.parse("$baseUrl/carts/add");

    final res = await http.post(url, body: {
      "product_id": productId.toString()
    });

    return res.statusCode == 200;
  }
}
