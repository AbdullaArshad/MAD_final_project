import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../main_screen.dart';
import '../../data/models.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final Course course;

  const PaymentSuccessScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, size: 100, color: Colors.green),
              const SizedBox(height: 32),
              Text(
                'Payment Successful!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
              ),
              const SizedBox(height: 16),
              const Text(
                'You have successfully enrolled in the course. Start learning now!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      final userDoc = FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid);

                      await userDoc
                          .collection('enrolled_courses')
                          .doc(course.id)
                          .set({
                        'title': course.title,
                        'instructor': course.instructor,
                        'price': course.price,
                        'imageUrl': course.imageUrl,
                        'enrolledAt': FieldValue.serverTimestamp(),
                      });
                    }

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainScreen()),
                      (route) => false,
                    );
                  },
                  child: const Text('Go to Home'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
