import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductService {
  static const String baseUrl = 'http://10.11.12.234:3000';

  static Future<List<ProductModel>> getProducts() async {
    final res = await http.get(Uri.parse('$baseUrl/products'));

    if (res.statusCode != 200) {
      throw Exception('Gagal load produk');
    }

    final body = json.decode(res.body);
    final List list = body['data']; // 🔥 WAJIB PAKAI data

    return list.map((e) => ProductModel.fromJson(e)).toList();
  }

  static Future<void> addProduct(Map<String, dynamic> data) async {
    await http.post(
      Uri.parse('$baseUrl/products'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
  }

  static Future<void> updateProduct(int id, Map<String, dynamic> data) async {
    await http.put(
      Uri.parse('$baseUrl/products/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
  }

  static Future<void> deleteProduct(int id) async {
    await http.delete(Uri.parse('$baseUrl/products/$id'));
  }
}
