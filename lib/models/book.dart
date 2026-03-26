// Cup&Book - Book Model

import 'book_rating.dart';

enum AgeRange {
  allAges('All Ages'),
  boardBooks('Board Books 0-3'),
  pictureBooks('Picture Books 3-8'),
  earlyReaders('Early Readers 4-8'),
  chapterBooks('Chapter Books 6-9'),
  middleGrade('Middle Grade 8-12'),
  youngAdult('Young Adult 12-18'),
  adult('Adult');

  final String label;
  const AgeRange(this.label);
}

enum Genre {
  fantasy('Fantasy'),
  sciFi('Sci-Fi'),
  mystery('Mystery'),
  adventure('Adventure'),
  romance('Romance'),
  historical('Historical'),
  graphicNovels('Graphic Novels'),
  nonFiction('Non-Fiction');

  final String label;
  const Genre(this.label);
}

class Book {
  final String id;
  final String title;
  final String author;
  final String? coverImageUrl;
  final int pageCount;
  final String description;
  final AgeRange ageRange;
  final List<Genre> genres;
  final BookRating rating;
  final int reviewCount;
  final double communityRating; // 1-5 stars
  final List<Review> reviews;
  final Map<String, String> purchaseLinks; // retailer -> url

  const Book({
    required this.id,
    required this.title,
    required this.author,
    this.coverImageUrl,
    required this.pageCount,
    required this.description,
    required this.ageRange,
    required this.genres,
    required this.rating,
    this.reviewCount = 0,
    this.communityRating = 0.0,
    this.reviews = const [],
    this.purchaseLinks = const {},
  });
}

class Review {
  final String id;
  final String userId;
  final String userName;
  final String content;
  final Map<int, String>? pageReferences; // page number -> content example
  final DateTime date;
  final int helpfulCount;

  const Review({
    required this.id,
    required this.userId,
    required this.userName,
    required this.content,
    this.pageReferences,
    required this.date,
    this.helpfulCount = 0,
  });
}