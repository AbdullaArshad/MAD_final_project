import 'package:flutter/material.dart';
import '../../core/app_theme.dart';

class CertificateScreen extends StatelessWidget {
  const CertificateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Certificate')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.primaryColor, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.workspace_premium,
                      size: 80,
                      color: AppTheme.secondaryColor,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Certificate of Completion',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'serif',
                          ),
                    ),
                    const SizedBox(height: 16),
                    const Text('This certifies that'),
                    const SizedBox(height: 8),
                    Text(
                      'Alex Johnson',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                    ),
                    const SizedBox(height: 8),
                    const Text('has successfully completed the course'),
                    const SizedBox(height: 16),
                    const Text(
                      'Flutter Masterclass',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Date',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(DateTime.now().toString().split(' ')[0]),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'Signature',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              'Instructor',
                              style: TextStyle(
                                fontFamily: 'cursive',
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download),
                  label: const Text('Download PDF'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
