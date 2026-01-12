class Review {
  final int productId;
  final String review;
  final int rating;

  Review({
    required this.productId,
    required this.review,
    required this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      productId: json['product_id'],
      review: json['review'], // ⬅️ PENTING
      rating: json['rating'],
    );
  }
}
