import 'package:flutter/material.dart';
import '../models/models.dart';

class BookDetailScreen extends StatelessWidget {
  final Book book;

  const BookDetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final rating = book.rating;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Details'),
        backgroundColor: Colors.brown[800],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Section: Cover + Basic Info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cover Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: book.coverImageUrl != null
                      ? Image.network(
                          book.coverImageUrl!,
                          width: 120,
                          height: 180,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 120,
                            height: 180,
                            color: Colors.brown[200],
                            child: const Icon(Icons.book, size: 60),
                          ),
                        )
                      : Container(
                          width: 120,
                          height: 180,
                          color: Colors.brown[200],
                          child: const Icon(Icons.book, size: 60),
                        ),
                ),
                const SizedBox(width: 16),

                // Book Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'by ${book.author}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.menu_book, size: 16),
                          const SizedBox(width: 4),
                          Text('${book.pageCount} pages'),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.person_outline, size: 16),
                          const SizedBox(width: 4),
                          Text(book.ageRange.label),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Genres
                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: book.genres.map((g) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.brown[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              g.label,
                              style: const TextStyle(fontSize: 12),
                            ),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 12),

                      // Community Rating
                      if (book.communityRating > 0) ...[
                        Row(
                          children: [
                            ...List.generate(5, (i) {
                              return Icon(
                                i < book.communityRating.round()
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 20,
                              );
                            }),
                            const SizedBox(width: 8),
                            Text(
                              '${book.communityRating}/5',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text(
                          '${book.reviewCount} community reviews',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Description
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              book.description,
              style: TextStyle(
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),

            const SizedBox(height: 24),

            // Content Ratings
            const Text(
              'Content Ratings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            _RatingRow(
              label: 'Violence',
              value: rating.violence.value,
              description: rating.violence.label,
            ),
            _RatingRow(
              label: 'Profanity',
              value: rating.profanity.value,
              description: rating.profanity.label,
            ),
            _RatingRow(
              label: 'Sexual Content',
              value: rating.sexualContent.value,
              description: rating.sexualContent.label,
            ),
            _RatingRow(
              label: 'Scary Themes',
              value: rating.scaryThemes.value,
              description: rating.scaryThemes.label,
            ),
            _RatingRow(
              label: 'Mature Topics',
              value: rating.matureTopics.value,
              description: rating.matureTopics.label,
            ),

            const SizedBox(height: 24),

            // Where to Buy
            if (book.purchaseLinks.isNotEmpty) ...[
              const Text(
                'Where to Buy',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: book.purchaseLinks.entries.map((entry) {
                  return ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Open URL
                    },
                    icon: const Icon(Icons.shopping_cart, size: 18),
                    label: Text(entry.key),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown[700],
                      foregroundColor: Colors.white,
                    ),
                  );
                }).toList(),
              ),
            ],

            const SizedBox(height: 24),

            // Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Add to bookshelf
                    },
                    icon: const Icon(Icons.bookmark_add),
                    label: const Text('Add to Bookshelf'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Write review
                    },
                    icon: const Icon(Icons.rate_review),
                    label: const Text('Write Review'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _RatingRow extends StatelessWidget {
  final String label;
  final int value;
  final String description;

  const _RatingRow({
    required this.label,
    required this.value,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getColor(value);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          // Rating bars
          Expanded(
            child: Row(
              children: List.generate(5, (i) {
                return Expanded(
                  child: Container(
                    height: 20,
                    margin: const EdgeInsets.only(right: 4),
                    decoration: BoxDecoration(
                      color: i < value ? color : Colors.grey[200],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                );
              }),
            ),
          ),
          Container(
            width: 60,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '$value',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getColor(int value) {
    if (value <= 1) return Colors.green;
    if (value <= 2) return Colors.green[300]!;
    if (value <= 3) return Colors.yellow[700]!;
    if (value <= 4) return Colors.orange;
    return Colors.red;
  }
}