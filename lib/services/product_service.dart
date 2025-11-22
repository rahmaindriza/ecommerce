import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/product_model.dart';

class ProductService {
  final String baseUrl = "http://192.168.18.238:3000"; // ganti dengan URL API kamu

  Future<List<ProductModel>> getProducts() async {
    final response = await http.get(Uri.parse("$baseUrl/products"));

    if (response.statusCode == 200) {
      return productModelFromJson(response.body);
    } else {
      throw Exception("Gagal load data produk");
    }
  }
}
