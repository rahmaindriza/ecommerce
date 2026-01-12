import 'dart:convert';
import 'package:http/http.dart' as http;

class ReviewService {
  final String baseUrl = "http://10.11.12.234:5002";

  // =============================
  // 1️⃣ Ambil semua review
  // =============================
  Future<List<dynamic>> getReviews() async {
    final url = Uri.parse("$baseUrl/reviews/list");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return [];
  }

  // =============================
  // 2️⃣ Ambil review by ID
  // =============================
  Future<dynamic> getReviewById(int id) async {
    final url = Uri.parse("$baseUrl/reviews/$id");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  // =============================
  // 3️⃣ Ambil review berdasarkan PRODUCT ID
  // =============================
  Future<List<dynamic>> getReviewByProduct(int productId) async {
    final url = Uri.parse("$baseUrl/reviews/product/$productId");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return [];
  }

  // =============================
  // 4️⃣ Tambah review baru (FIXED)
  // =============================
  Future<bool> addReview({
    required int productId,
    required double rating,
    required String review,
  }) async {
    final url = Uri.parse("$baseUrl/reviews");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "product_id": productId,
        "rating": rating,
        "review": review,
      }),
    );

    print("STATUS CODE: ${response.statusCode}");
    print("BODY: ${response.body}");

    // FIX: backend kamu kirim 200, bukan 201
    return response.statusCode == 200 || response.statusCode == 201;
  }
}
