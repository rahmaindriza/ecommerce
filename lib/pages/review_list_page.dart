import 'package:flutter/material.dart';
import '../models/review_model.dart';
import '../services/review_service.dart';
import 'add_review_page.dart';

class ReviewListPage extends StatefulWidget {
  final int productId;

  const ReviewListPage({super.key, required this.productId});

  @override
  State<ReviewListPage> createState() => _ReviewListPageState();
}

class _ReviewListPageState extends State<ReviewListPage> {
  final ReviewService _service = ReviewService();
  List<Review> reviews = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadReviews();
  }

  Future<void> loadReviews() async {
    setState(() => loading = true);
    reviews = await _service.getReviewByProduct(widget.productId);
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EEDC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFA47449),
        title: const Text("Review", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_comment),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddReviewPage(productId: widget.productId),
                ),
              );
              if (result == true) loadReviews();
            },
          ),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : reviews.isEmpty
          ? const Center(child: Text("Belum ada review"))
          : ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, i) {
          final r = reviews[i];
          return Card(
            child: ListTile(
              title: Text(r.review), // ⬅️ FIX ERROR DI SINI
              subtitle: Row(
                children: List.generate(
                  5,
                      (j) => Icon(
                    Icons.star,
                    size: 16,
                    color: j < r.rating
                        ? Colors.orange
                        : Colors.grey,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
