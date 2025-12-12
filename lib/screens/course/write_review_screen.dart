import 'package:flutter/material.dart';
import '../../data/models.dart';

class WriteReviewScreen extends StatelessWidget {
  final Course course;

  const WriteReviewScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Write a Review')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              'How was the course?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: const Icon(
                    Icons.star_border,
                    size: 40,
                    color: Colors.amber,
                  ),
                  onPressed: () {},
                );
              }),
            ),
            const SizedBox(height: 32),
            TextFormField(
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Share your experience...',
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Submit Review'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
