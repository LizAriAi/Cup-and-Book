// Cup&Book - User & Circle Models

import 'book.dart';

class User {
  final String id;
  final String email;
  final String displayName;
  final List<String> familyMemberIds;
  final Bookshelf personalBookshelf;
  final List<String> circleIds;

  const User({
    required this.id,
    required this.email,
    required this.displayName,
    this.familyMemberIds = const [],
    required this.personalBookshelf,
    this.circleIds = const [],
  });
}

class FamilyMember {
  final String id;
  final String name;
  final int age;
  final BookRatingFilters filters;
  final Bookshelf bookshelf;

  const FamilyMember({
    required this.id,
    required this.name,
    required this.age,
    required this.filters,
    required this.bookshelf,
  });
}

class BookRatingFilters {
  final int maxViolence;
  final int maxProfanity;
  final int maxSexualContent;
  final int maxScaryThemes;
  final int maxMatureTopics;
  final List<Genre> allowedGenres;
  final List<Genre> excludedGenres;

  const BookRatingFilters({
    this.maxViolence = 5,
    this.maxProfanity = 5,
    this.maxSexualContent = 5,
    this.maxScaryThemes = 5,
    this.maxMatureTopics = 5,
    this.allowedGenres = const [],
    this.excludedGenres = const [],
  });

  bool bookPassesFilters(Book book) {
    final r = book.rating;
    return r.violence.value <= maxViolence &&
        r.profanity.value <= maxProfanity &&
        r.sexualContent.value <= maxSexualContent &&
        r.scaryThemes.value <= maxScaryThemes &&
        r.matureTopics.value <= maxMatureTopics;
  }
}

class Bookshelf {
  final String id;
  final String name;
  final List<BookshelfEntry> books;

  const Bookshelf({
    required this.id,
    required this.name,
    this.books = const [],
  });
}

class BookshelfEntry {
  final String bookId;
  final DateTime addedDate;
  final bool isRead;
  final int? personalRating; // 1-5 stars
  final String? personalNote;

  const BookshelfEntry({
    required this.bookId,
    required this.addedDate,
    this.isRead = false,
    this.personalRating,
    this.personalNote,
  });
}

class Circle {
  final String id;
  final String name;
  final String description;
  final List<String> memberIds;
  final List<String> currentReadingBookIds;
  final List<String> completedBookIds;
  final List<String> wishlistBookIds;
  final List<CircleMessage> chat;

  const Circle({
    required this.id,
    required this.name,
    this.description = '',
    this.memberIds = const [],
    this.currentReadingBookIds = const [],
    this.completedBookIds = const [],
    this.wishlistBookIds = const [],
    this.chat = const [],
  });
}

class CircleMessage {
  final String id;
  final String userId;
  final String userName;
  final String content;
  final DateTime timestamp;

  const CircleMessage({
    required this.id,
    required this.userId,
    required this.userName,
    required this.content,
    required this.timestamp,
  });
}