import 'models.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:cloud_firestore/cloud_firestore.dart';

// --------------------
// Fetch Current Logged-in User from Firestore
// --------------------
Future<User?> getCurrentUser() async {
  final firebaseUser = fb.FirebaseAuth.instance.currentUser;
  if (firebaseUser == null) return null;

  final doc = await FirebaseFirestore.instance
      .collection('users')
      .doc(firebaseUser.uid)
      .get();

  if (!doc.exists) return null;

  return User(
    id: firebaseUser.uid,
    name: doc['name'] ?? 'User',
    email: doc['email'] ?? firebaseUser.email ?? '',
    avatarUrl:
        doc['avatarUrl'] ?? 'https://i.pravatar.cc/150?u=${firebaseUser.uid}',
  );
}

// --------------------
// Static Categories
// --------------------
final categories = [
  Category(id: '1', name: 'Design', iconEmoji: '🎨'),
  Category(id: '2', name: 'Coding', iconEmoji: '💻'),
  Category(id: '3', name: 'Business', iconEmoji: '📊'),
  Category(id: '4', name: 'Marketing', iconEmoji: '📱'),
  Category(id: '5', name: 'Photography', iconEmoji: '📷'),
  Category(id: '6', name: 'Music', iconEmoji: '🎵'),
  Category(id: '7', name: 'Fitness', iconEmoji: '💪'),
  Category(id: '8', name: 'Language', iconEmoji: '🌍'),
];

// --------------------
// Courses Generation (Same as Before)
// --------------------
final courses = _generateCourses();

List<Course> _generateCourses() {
  final courseTemplates = [
    {
      'title': 'UI/UX Design Masterclass',
      'category': 0,
      'price': 89.99,
      'rating': 4.8,
      'instructor': 'Sarah Chen'
    },
    {
      'title': 'Graphic Design Fundamentals',
      'category': 0,
      'price': 79.99,
      'rating': 4.7,
      'instructor': 'Mike Ross'
    },
    {
      'title': 'Flutter Mobile Development',
      'category': 1,
      'price': 94.99,
      'rating': 4.9,
      'instructor': 'Dr. Angela Yu'
    },
    {
      'title': 'Python Programming Complete',
      'category': 1,
      'price': 84.99,
      'rating': 4.8,
      'instructor': 'Jose Portilla'
    },
    {
      'title': 'JavaScript ES6+ Masterclass',
      'category': 1,
      'price': 79.99,
      'rating': 4.7,
      'instructor': 'Brad Traversy'
    },
    {
      'title': 'MBA Essentials',
      'category': 2,
      'price': 129.99,
      'rating': 4.7,
      'instructor': 'Chris Haroun'
    },
    {
      'title': 'Project Management Professional',
      'category': 2,
      'price': 99.99,
      'rating': 4.8,
      'instructor': 'Joseph Phillips'
    },
    {
      'title': 'Digital Marketing Masterclass',
      'category': 3,
      'price': 89.99,
      'rating': 4.8,
      'instructor': 'Phil Ebiner'
    },
    {
      'title': 'Social Media Marketing 2024',
      'category': 3,
      'price': 74.99,
      'rating': 4.7,
      'instructor': 'Neil Patel'
    },
    {
      'title': 'Photography Masterclass',
      'category': 4,
      'price': 94.99,
      'rating': 4.9,
      'instructor': 'Phil Ebiner'
    },
  ];

  final List<Course> generatedCourses = [];
  for (int i = 0; i < courseTemplates.length; i++) {
    final template = courseTemplates[i];
    final categoryIndex = template['category'] as int;

    generatedCourses.add(
      Course(
        id: '${i + 1}',
        title: template['title'] as String,
        description:
            'Master ${template['title']} with hands-on projects and real-world examples. Learn from industry experts and build your portfolio.',
        instructor: template['instructor'] as String,
        price: template['price'] as double,
        rating: template['rating'] as double,
        reviewsCount: 1000 + (i * 100),
        duration: '${8 + (i % 12)}h ${(i * 15) % 60}m',
        imageUrl: 'https://picsum.photos/seed/${i + 100}/400/300',
        category: categories[categoryIndex],
        lessons: _generateLessons(i),
        reviews: _generateReviews(i),
      ),
    );
  }

  return generatedCourses;
}

List<Lesson> _generateLessons(int courseIndex) {
  return [
    Lesson(
        id: '${courseIndex}_1',
        title: 'Introduction & Overview',
        duration: '12:30',
        isLocked: false),
    Lesson(
        id: '${courseIndex}_2',
        title: 'Getting Started',
        duration: '18:45',
        isLocked: false),
    Lesson(
        id: '${courseIndex}_3',
        title: 'Core Concepts',
        duration: '25:15',
        isLocked: true),
    Lesson(
        id: '${courseIndex}_4',
        title: 'Advanced Techniques',
        duration: '32:20',
        isLocked: true),
    Lesson(
        id: '${courseIndex}_5',
        title: 'Final Project',
        duration: '45:00',
        isLocked: true),
  ];
}

List<Review> _generateReviews(int courseIndex) {
  final reviewers = [
    {'name': 'John Doe', 'avatar': 'https://i.pravatar.cc/150?u=john'},
    {'name': 'Jane Smith', 'avatar': 'https://i.pravatar.cc/150?u=jane'},
    {'name': 'Mike Johnson', 'avatar': 'https://i.pravatar.cc/150?u=mike'},
  ];

  return reviewers.map((reviewer) {
    return Review(
      id: '${courseIndex}_review_${reviewer['name']}',
      user: User(
        id: reviewer['name']!,
        name: reviewer['name']!,
        email:
            '${reviewer['name']!.toLowerCase().replaceAll(' ', '.')}@example.com',
        avatarUrl: reviewer['avatar']!,
      ),
      rating: 4.5 + (courseIndex % 5) * 0.1,
      comment:
          'Great course! Learned a lot and the instructor explains everything clearly.',
      date: DateTime.now().subtract(Duration(days: courseIndex)),
    );
  }).toList();
}
