import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/review_model.dart';

class ReviewService {
  static const String baseUrl = "http://10.11.12.234:5002"; // emulator

  /// ADD REVIEW
  Future<bool> addReview({
    required int productId,
    required String reviewText,
    required int rating,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/reviews"),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: {
        "product_id": productId.toString(),
        "review_text": reviewText, // ⬅️ SAMA DENGAN BACKEND
        "rating": rating.toString(),
      },
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }

  /// GET REVIEW BY PRODUCT
  Future<List<Review>> getReviewByProduct(int productId) async {
    final response =
    await http.get(Uri.parse("$baseUrl/reviews/$productId"));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List list = jsonData['data'];

      return list.map((e) => Review.fromJson(e)).toList();
    } else {
      throw Exception("Gagal memuat review");
    }
  }
}
