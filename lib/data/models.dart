class User {
  String id;
  String name;
  String email;
  String avatarUrl;
  String bio;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
    this.bio = 'Passionate learner and explorer.',
  });

  factory User.fromMap(Map<String, dynamic> map, String id) {
    return User(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      avatarUrl: map['avatarUrl'] ?? '',
      bio: map['bio'] ?? 'Passionate learner and explorer.',
    );
  }
}

class Category {
  final String id;
  final String name;
  final String iconEmoji;
  final String description;

  Category({
    required this.id,
    required this.name,
    required this.iconEmoji,
    this.description = '',
  });

  factory Category.fromMap(Map<String, dynamic> map, String id) {
    return Category(
      id: id,
      name: map['name'] ?? '',
      iconEmoji: map['iconEmoji'] ?? '',
      description: map['description'] ?? '',
    );
  }
}

class Lesson {
  final String id;
  final String title;
  final String duration;
  final bool isLocked;
  final String description;

  Lesson({
    required this.id,
    required this.title,
    required this.duration,
    this.isLocked = true,
    this.description = '',
  });

  factory Lesson.fromMap(Map<String, dynamic> map, String id) {
    return Lesson(
      id: id,
      title: map['title'] ?? '',
      duration: map['duration'] ?? '',
      isLocked: map['isLocked'] ?? true,
      description: map['description'] ?? '',
    );
  }
}

class Review {
  final String id;
  final User user;
  final double rating;
  final String comment;
  final DateTime date;

  Review({
    required this.id,
    required this.user,
    required this.rating,
    required this.comment,
    required this.date,
  });

  factory Review.fromMap(Map<String, dynamic> map, String id) {
    return Review(
      id: id,
      user: User.fromMap(map['user'] ?? {}, map['user']['id'] ?? ''),
      rating: (map['rating'] ?? 0).toDouble(),
      comment: map['comment'] ?? '',
      date: map['date'] != null ? DateTime.parse(map['date']) : DateTime.now(),
    );
  }
}

class Course {
  final String id;
  final String title;
  final String instructor;
  final double rating;
  final int reviewsCount;
  final String duration;
  final double price;
  final String imageUrl;
  final String description;
  final List<Lesson> lessons;
  final Category category;
  final List<Review> reviews;

  Course({
    required this.id,
    required this.title,
    required this.instructor,
    required this.rating,
    required this.reviewsCount,
    required this.duration,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.lessons,
    required this.category,
    this.reviews = const [],
  });

  factory Course.fromMap(Map<String, dynamic> map, String id) {
    return Course(
      id: id,
      title: map['title'] ?? '',
      instructor: map['instructor'] ?? '',
      rating: (map['rating'] ?? 0).toDouble(),
      reviewsCount: map['reviewsCount'] ?? 0,
      duration: map['duration'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      imageUrl: map['imageUrl'] ?? '',
      description: map['description'] ?? '',
      lessons: map['lessons'] != null
          ? List<Lesson>.from((map['lessons'] as List)
              .map((l) => Lesson.fromMap(l, l['id'] ?? '')))
          : [],
      category: map['category'] != null
          ? Category.fromMap(map['category'], map['category']['id'] ?? '')
          : Category(id: '', name: '', iconEmoji: ''),
      reviews: map['reviews'] != null
          ? List<Review>.from((map['reviews'] as List)
              .map((r) => Review.fromMap(r, r['id'] ?? '')))
          : [],
    );
  }
}
