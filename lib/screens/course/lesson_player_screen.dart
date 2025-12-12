import 'package:flutter/material.dart';
import '../../data/models.dart';

class LessonPlayerScreen extends StatelessWidget {
  final Lesson lesson;
  final Course course;

  const LessonPlayerScreen({
    super.key,
    required this.lesson,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Video Player Placeholder
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                children: [
                  Container(
                    color: Colors.black,
                    child: const Center(
                      child: Icon(
                        Icons.play_circle_fill,
                        size: 64,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: CircleAvatar(
                      backgroundColor: Colors.black45,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            course.title,
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            lesson.title,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Icon(
                                Icons.timer_outlined,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                lesson.duration,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: course.lessons.length,
                        itemBuilder: (context, index) {
                          final l = course.lessons[index];
                          final isCurrent = l.id == lesson.id;
                          return ListTile(
                            selected: isCurrent,
                            selectedTileColor: Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.05),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            leading: Icon(
                              l.isLocked
                                  ? Icons.lock
                                  : (isCurrent
                                        ? Icons.pause_circle_filled
                                        : Icons.play_circle_outline),
                              color: isCurrent
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey,
                            ),
                            title: Text(
                              l.title,
                              style: TextStyle(
                                fontWeight: isCurrent
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: isCurrent
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.black87,
                              ),
                            ),
                            trailing: Text(
                              l.duration,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            onTap: l.isLocked
                                ? null
                                : () {
                                    if (!isCurrent) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (c) => LessonPlayerScreen(
                                            lesson: l,
                                            course: course,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
