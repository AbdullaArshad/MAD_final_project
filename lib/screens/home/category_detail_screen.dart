import 'package:flutter/material.dart';
import '../../data/models.dart';
import '../../data/mock_data.dart';
import '../../widgets/course_card.dart';

class CategoryDetailScreen extends StatelessWidget {
  final Category category;

  const CategoryDetailScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final categoryCourses = courses
        .where((c) => c.category.id == category.id)
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text('${category.iconEmoji} ${category.name}')),
      body: categoryCourses.isEmpty
          ? Center(
              child: Text(
                'No courses found in this category',
                style: TextStyle(color: Colors.grey[500]),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: categoryCourses.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: CourseCard(
                    course: categoryCourses[index],
                    isHorizontal: false,
                  ),
                );
              },
            ),
    );
  }
}
