import 'package:flutter/material.dart';
import '../services/review_service.dart';

class AddReviewPage extends StatefulWidget {
  final int productId;

  AddReviewPage({required this.productId});

  @override
  _AddReviewPageState createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  final TextEditingController reviewController = TextEditingController();
  double rating = 0.0;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EEDC),
      appBar: AppBar(
        title: const Text("Tambah Review", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFA47449),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Rating",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4B322D),
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: List.generate(5, (index) {
                return IconButton(
                  onPressed: () {
                    setState(() {
                      rating = index + 1.0;
                    });
                  },
                  icon: Icon(
                    Icons.star,
                    size: 32,
                    color: (index < rating) ? Colors.orange : Colors.grey,
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),

            const Text(
              "Tulis Review",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4B322D),
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: reviewController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Tulis pengalamanmu...",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: loading ? null : submitReview,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA47449),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Kirim Review", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> submitReview() async {
    if (rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Rating tidak boleh kosong")),
      );
      return;
    }

    if (reviewController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Review tidak boleh kosong")),
      );
      return;
    }

    setState(() => loading = true);

    bool success = await ReviewService().addReview(
      productId: widget.productId,
      rating: rating,
      review: reviewController.text,
    );

    setState(() => loading = false);

    if (success) {
      Navigator.pop(context, true); // kembali ke previous page
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal menambahkan review")),
      );
    }
  }
}
