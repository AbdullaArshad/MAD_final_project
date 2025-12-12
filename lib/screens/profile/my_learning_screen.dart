import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../widgets/course_card.dart';

class MyLearningScreen extends StatelessWidget {
  const MyLearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use mock courses for display
    final activeCourses =
        courses.where((c) => c.lessons.any((l) => l.isLocked)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Learning'),
        automaticallyImplyLeading: false,
      ),
      body: activeCourses.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.school_outlined,
                    size: 80,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No active courses',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: activeCourses.length,
              itemBuilder: (context, index) {
                final course = activeCourses[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: CourseCard(course: course, isHorizontal: false),
                );
              },
            ),
    );
  }
}
