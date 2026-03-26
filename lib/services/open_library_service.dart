// Cup&Book - Open Library API Service

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class OpenLibraryService {
  static const String _baseUrl = 'https://openlibrary.org';

  /// Search for books by title, author, or ISBN
  Future<List<Book>> searchBooks(String query) async {
    final encodedQuery = Uri.encodeComponent(query);
    final url = '$_baseUrl/search.json?q=$encodedQuery&limit=20';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('Failed to search books: ${response.statusCode}');
    }

    final data = json.decode(response.body);
    final docs = data['docs'] as List;

    final books = <Book>[];
    for (final doc in docs) {
      final book = _parseSearchResult(doc);
      if (book != null) {
        books.add(book);
      }
    }

    return books;
  }

  /// Get book details by Open Library key
  Future<Book?> getBookDetails(String olid) async {
    final url = '$_baseUrl/works/$olid.json';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      return null;
    }

    final data = json.decode(response.body);
    return _parseWorkDetails(data);
  }

  /// Get book cover URL
  String? getCoverUrl(String? coverId, {String size = 'M'}) {
    if (coverId == null) return null;
    return 'https://covers.openlibrary.org/b/id/$coverId-$size.jpg';
  }

  Book? _parseSearchResult(Map<String, dynamic> doc) {
    try {
      final title = doc['title'] as String?;
      if (title == null) return null;

      final authorNames = doc['author_name'] as List?;
      final author = authorNames?.isNotEmpty == true
          ? authorNames!.first as String
          : 'Unknown Author';

      final coverId = doc['cover_i'] as int?;
      final coverUrl = getCoverUrl(coverId?.toString());

      final pageCount = doc['number_of_pages_median'] as int? ?? 0;
      final publishYear = doc['first_publish_year'] as int?;

      final isbnList = doc['isbn'] as List?;
      final isbn = isbnList?.isNotEmpty == true ? isbnList!.first as String : null;

      final olid = doc['key'] as String??.replaceAll('/works/', '');

      // Map to age range (simplified)
      final firstPublishYear = publishYear ?? 2020;
      AgeRange ageRange;
      if (firstPublishYear < 2010) {
        ageRange = AgeRange.middleGrade;
      } else {
        ageRange = AgeRange.youngAdult;
      }

      // Parse genres from subject
      final subjectList = doc['subject'] as List?;
      final genres = _parseGenres(subjectList);

      return Book(
        id: olid ?? isbn ?? title,
        title: title,
        author: author,
        coverImageUrl: coverUrl,
        pageCount: pageCount,
        description: 'A book by $author',
        ageRange: ageRange,
        genres: genres,
        rating: const BookRating(
          violence: ViolenceLevel.none,
          profanity: ProfanityLevel.none,
          sexualContent: SexualContentLevel.none,
          scaryThemes: ScaryLevel.sunny,
          matureTopics: MatureTopicsLevel.none,
        ),
      );
    } catch (e) {
      return null;
    }
  }

  Book _parseWorkDetails(Map<String, dynamic> data) {
    final title = data['title'] as String? ?? 'Unknown';
    final description = data['description'] is String
        ? data['description'] as String
        : data['description'] is Map
            ? (data['description']['value'] as String? ?? '')
            : '';

    final covers = data['covers'] as List?;
    final coverUrl = covers?.isNotEmpty == true
        ? 'https://covers.openlibrary.org/b/id/${covers!.first}-M.jpg'
        : null;

    return Book(
      id: data['key']?.toString() ?? title,
      title: title,
      author: 'Unknown', // Would need another call for authors
      coverImageUrl: coverUrl,
      pageCount: 0,
      description: description,
      ageRange: AgeRange.allAges,
      genres: const [],
      rating: const BookRating(
        violence: ViolenceLevel.none,
        profanity: ProfanityLevel.none,
        sexualContent: SexualContentLevel.none,
        scaryThemes: ScaryLevel.sunny,
        matureTopics: MatureTopicsLevel.none,
      ),
    );
  }

  List<Genre> _parseGenres(List? subjects) {
    if (subjects == null || subjects.isEmpty) return [];

    final genreLabels = subjects
        .take(10)
        .map((s) => s.toString().toLowerCase())
        .toList();

    final genres = <Genre>[];

    for (final label in genreLabels) {
      if (label.contains('fantasy')) genres.add(Genre.fantasy);
      if (label.contains('science fiction') || label.contains('sci-fi')) {
        genres.add(Genre.sciFi);
      }
      if (label.contains('mystery')) genres.add(Genre.mystery);
      if (label.contains('adventure')) genres.add(Genre.adventure);
      if (label.contains('romance')) genres.add(Genre.romance);
      if (label.contains('historical') || label.contains('history')) {
        genres.add(Genre.historical);
      }
      if (label.contains('graphic')) genres.add(Genre.graphicNovels);
      if (label.contains('non-fiction') || label.contains('nonfiction')) {
        genres.add(Genre.nonFiction);
      }
    }

    return genres.toSet().toList();
  }
}