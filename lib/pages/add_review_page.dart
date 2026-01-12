import 'package:flutter/material.dart';
import '../services/review_service.dart';

class AddReviewPage extends StatefulWidget {
  final int productId;

  const AddReviewPage({super.key, required this.productId});

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  final TextEditingController reviewController = TextEditingController();
  int rating = 5;
  bool loading = false;

  final ReviewService _service = ReviewService();

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  Future<void> submitReview() async {
    FocusScope.of(context).unfocus(); // ⬅️ FIX WARNING KEYBOARD

    if (reviewController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Review tidak boleh kosong")));
      return;
    }

    setState(() => loading = true);

    try {
      final success = await _service.addReview(
        productId: widget.productId,
        reviewText: reviewController.text.trim(),
        rating: rating,
      );

      if (success) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EEDC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFA47449),
        title: const Text("Tambah Review", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: List.generate(5, (i) {
                  return IconButton(
                    icon: Icon(
                      Icons.star,
                      color: i < rating ? Colors.orange : Colors.grey,
                    ),
                    onPressed: () => setState(() => rating = i + 1),
                  );
                }),
              ),
              TextField(
                controller: reviewController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: "Tulis review...",
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: loading ? null : submitReview,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA47449),
                ),
                child: loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Kirim", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
