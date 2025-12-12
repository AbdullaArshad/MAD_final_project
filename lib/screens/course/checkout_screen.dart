import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/models.dart';
import 'payment_success_screen.dart';

class CheckoutScreen extends StatelessWidget {
  final Course course;

  const CheckoutScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Course Summary
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      course.imageUrl,
                      width: 100,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 2,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'By ${course.instructor}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              const Text(
                'Payment Method',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 16),
              _buildPaymentOption(
                  context, 'Credit Card', Icons.credit_card, true),
              const SizedBox(height: 12),
              _buildPaymentOption(context, 'PayPal', Icons.payment, false),
              const SizedBox(height: 12),
              _buildPaymentOption(context, 'Apple Pay', Icons.apple, false),

              const Spacer(),

              // Totals
              const Divider(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    '\$${course.price}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      // Get current user ID
                      final userId = FirebaseAuth.instance.currentUser!.uid;

                      // Reference to user's document
                      final userDoc = FirebaseFirestore.instance
                          .collection('users')
                          .doc(userId);

                      // Add course title to 'enrolledCourses' array
                      await userDoc.update({
                        'enrolledCourses': FieldValue.arrayUnion([course.title])
                      });

                      // Navigate to success screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PaymentSuccessScreen(course: course),
                        ),
                      );
                    } catch (e) {
                      // If the user's document does not exist, create it
                      final userId = FirebaseAuth.instance.currentUser!.uid;
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(userId)
                          .set({
                        'enrolledCourses': [course.title]
                      });

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PaymentSuccessScreen(course: course),
                        ),
                      );
                    }
                  },
                  child: const Text('Pay Now'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption(
    BuildContext context,
    String title,
    IconData icon,
    bool selected,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: selected
            ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.05)
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: selected
              ? Theme.of(context).colorScheme.primary
              : Colors.grey[200]!,
        ),
      ),
      child: Row(
        children: [
          Icon(icon,
              color: selected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey),
          const SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: selected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.black87,
            ),
          ),
          const Spacer(),
          if (selected)
            Icon(Icons.check_circle,
                color: Theme.of(context).colorScheme.primary),
        ],
      ),
    );
  }
}
