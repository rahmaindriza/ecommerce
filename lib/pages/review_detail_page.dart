import 'package:flutter/material.dart';

class ReviewDetailPage extends StatelessWidget {
  final Map review;

  ReviewDetailPage({required this.review});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EEDC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFA47449),
        title: const Text("Detail Review", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("⭐ ${review['rating']}",
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),

              const SizedBox(height: 10),

              const Text("Review:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

              const SizedBox(height: 8),

              Text(
                review['review'],
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
