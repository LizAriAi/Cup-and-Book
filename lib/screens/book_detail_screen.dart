import 'package:flutter/material.dart';
import '../models/models.dart';

class BookDetailScreen extends StatefulWidget {
  final Book book;

  const BookDetailScreen({super.key, required this.book});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  bool _isDescriptionExpanded = false;
  static const int _descriptionMaxLines = 4;

  @override
  Widget build(BuildContext context) {
    final rating = widget.book.rating;
    final descriptionLength = widget.book.description.length;

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
            // Top Section: Cover + Basic Info with vertical divider
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cover Image (smaller, like Amazon button size)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: widget.book.coverImageUrl != null
                      ? Image.network(
                          widget.book.coverImageUrl!,
                          width: 80,
                          height: 120,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 80,
                            height: 120,
                            color: Colors.brown[200],
                            child: const Icon(Icons.book, size: 40),
                          ),
                        )
                      : Container(
                          width: 80,
                          height: 120,
                          color: Colors.brown[200],
                          child: const Icon(Icons.book, size: 40),
                        ),
                ),
                const SizedBox(width: 12),

                // Left side: Age Range + Genre
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.book.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'by ${widget.book.author}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.menu_book, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.book.pageCount} pages',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.person_outline, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            widget.book.ageRange.label,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Genres
                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: widget.book.genres.map((g) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.brown[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              g.label,
                              style: const TextStyle(fontSize: 10),
                            ),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 8),

                      // Community Rating
                      if (widget.book.communityRating > 0) ...[
                        Row(
                          children: [
                            ...List.generate(5, (i) {
                              return Icon(
                                i < widget.book.communityRating.round()
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 14,
                              );
                            }),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.book.communityRating}/5',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${widget.book.reviewCount} reviews',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Vertical divider line
                Container(
                  width: 1,
                  height: 180,
                  color: Colors.grey[300],
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                ),

                // Right side: Content Advisory
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Content Advisory',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Horizontal row with labels and ratings
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header row
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 70,
                                  child: Text(
                                    'Violence',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 70,
                                  child: Text(
                                    'Profanity',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 70,
                                  child: Text(
                                    'Sexual',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 70,
                                  child: Text(
                                    'Scary',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Rating dots row
                          Row(
                            children: [
                              _RatingDots(value: rating.violence.value, label: 'Violence'),
                              _RatingDots(value: rating.profanity.value, label: 'Profanity'),
                              _RatingDots(value: rating.sexualContent.value, label: 'Sexual'),
                              _RatingDots(value: rating.scaryThemes.value, label: 'Scary'),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Mature Topics
                          Row(
                            children: [
                              Text(
                                'Mature Topics: ',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[700],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: _getColor(rating.matureTopics.value)
                                      .withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  rating.matureTopics.label,
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: _getColor(rating.matureTopics.value),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Description (with read more if needed)
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.book.description,
                    style: TextStyle(
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                    maxLines: _isDescriptionExpanded ? null : _descriptionMaxLines,
                    overflow: _isDescriptionExpanded
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                  ),
                  if (descriptionLength > 200 && !_isDescriptionExpanded)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isDescriptionExpanded = true;
                        });
                      },
                      child: const Text('Read more'),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Where to Buy
            const Text(
              'Where to Buy',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.book.purchaseLinks.entries.map((entry) {
                return ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Open URL
                  },
                  icon: const Icon(Icons.shopping_cart, size: 14),
                  label: Text(
                    entry.key,
                    style: const TextStyle(fontSize: 12),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Add to bookshelf
                    },
                    icon: const Icon(Icons.bookmark_add, size: 18),
                    label: const Text('Add to Bookshelf'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Write review
                    },
                    icon: const Icon(Icons.rate_review, size: 18),
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

  Color _getColor(int value) {
    if (value <= 1) return Colors.green;
    if (value <= 2) return Colors.green[300]!;
    if (value <= 3) return Colors.yellow[700]!;
    if (value <= 4) return Colors.orange;
    return Colors.red;
  }
}

class _RatingDots extends StatelessWidget {
  final int value;
  final String label;

  const _RatingDots({
    required this.value,
    required this.label,
  });

  Color _getColor(int value) {
    if (value <= 1) return Colors.green;
    if (value <= 2) return Colors.green[300]!;
    if (value <= 3) return Colors.yellow[700]!;
    if (value <= 4) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(5, (i) {
              return Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.only(right: 2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i < value
                      ? _getColor(value)
                      : Colors.grey[200],
                  border: Border.all(
                    color: i < value
                        ? _getColor(value)
                        : Colors.grey[300]!,
                    width: 1,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 2),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            decoration: BoxDecoration(
              color: _getColor(value).withOpacity(0.2),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(
              '$value',
              style: TextStyle(
                fontSize: 9,
                color: _getColor(value),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}