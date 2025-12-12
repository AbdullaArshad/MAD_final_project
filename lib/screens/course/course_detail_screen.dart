import 'package:flutter/material.dart';
import '../../data/models.dart';
import 'lesson_player_screen.dart';
import 'checkout_screen.dart';
import 'review_list_screen.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 250,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        course.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(color: Colors.grey),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.7),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              course.category.name.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              course.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  const TabBar(
                    labelColor: Colors.black87,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Color(0xFF6C63FF),
                    tabs: [
                      Tab(text: "About"),
                      Tab(text: "Lessons"),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              // About Tab
              SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      course.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Instructor",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://i.pravatar.cc/150?u=instructor',
                        ),
                      ),
                      title: Text(
                        course.instructor,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text("Senior Instructor"),
                      trailing: IconButton(
                        icon: const Icon(Icons.message_outlined),
                        onPressed: () {},
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),

              // Lessons Tab
              ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: course.lessons.length,
                itemBuilder: (context, index) {
                  final lesson = course.lessons[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: lesson.isLocked
                            ? Colors.grey[200]
                            : Theme.of(
                                context,
                              ).colorScheme.primary.withValues(alpha: 0.1),
                        child: Icon(
                          lesson.isLocked ? Icons.lock : Icons.play_arrow,
                          color: lesson.isLocked
                              ? Colors.grey
                              : Theme.of(context).colorScheme.primary,
                          size: 20,
                        ),
                      ),
                      title: Text(
                        lesson.title,
                        style: TextStyle(
                          color: lesson.isLocked ? Colors.grey : Colors.black87,
                        ),
                      ),
                      subtitle: Text(lesson.duration),
                      trailing: Text(
                        "0${index + 1}",
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: lesson.isLocked
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LessonPlayerScreen(
                                    lesson: lesson,
                                    course: course,
                                  ),
                                ),
                              );
                            },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CheckoutScreen(course: course),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              "Enroll Now - ${course.price == 0 ? "Free" : "\$${course.price}"}",
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height + 1; // +1 for border
  @override
  double get maxExtent => _tabBar.preferredSize.height + 1;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _tabBar,
          Divider(height: 1, color: Colors.grey[200]),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
