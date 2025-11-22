import 'package:flutter/material.dart';
import '../services/review_service.dart';

class ReviewPage extends StatefulWidget {
  final int productId;

  ReviewPage({required this.productId});

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final ReviewService _service = ReviewService();
  late Future<List<dynamic>> reviews;

  @override
  void initState() {
    super.initState();
    reviews = _service.getReviewByProduct(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reviews")),
      body: FutureBuilder(
        future: reviews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Belum ada review"));
          }

          final data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final r = data[index];
              return ListTile(
                title: Text(r["review"]),
                subtitle: Text("Rating: ${r["rating"]}"),
              );
            },
          );
        },
      ),
    );
  }
}
