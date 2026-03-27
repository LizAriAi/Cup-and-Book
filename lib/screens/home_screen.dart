import 'package:flutter/material.dart';
import '../models/models.dart';
import '../data/seed_data.dart';
import 'book_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Book> _books = [];
  List<Book> _filteredBooks = [];
  bool _isLoading = false;

  // Filter state
  AgeRange? _selectedAgeRange;
  List<Genre> _selectedGenres = [];
  bool _showFilters = false;

  // Rating filters
  int _maxViolence = 5;
  int _maxProfanity = 5;
  int _maxSexual = 5;
  int _maxScary = 5;
  int _maxMature = 5;

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  void _loadBooks() {
    setState(() {
      _books = SeedData.getSampleBooks();
      _filteredBooks = _books;
    });
  }

  void _applyFilters() {
    setState(() {
      _filteredBooks = _books.where((book) {
        // Age range filter
        if (_selectedAgeRange != null && book.ageRange != _selectedAgeRange) {
          return false;
        }

        // Genre filter
        if (_selectedGenres.isNotEmpty) {
          final hasGenre = book.genres.any((g) => _selectedGenres.contains(g));
          if (!hasGenre) return false;
        }

        // Rating filters
        if (book.rating.violence.value > _maxViolence) return false;
        if (book.rating.profanity.value > _maxProfanity) return false;
        if (book.rating.sexualContent.value > _maxSexual) return false;
        if (book.rating.scaryThemes.value > _maxScary) return false;
        if (book.rating.matureTopics.value > _maxMature) return false;

        return true;
      }).toList();
    });
  }

  void _clearFilters() {
    setState(() {
      _selectedAgeRange = null;
      _selectedGenres = [];
      _maxViolence = 5;
      _maxProfanity = 5;
      _maxSexual = 5;
      _maxScary = 5;
      _maxMature = 5;
      _filteredBooks = _books;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('☕ '),
            const Text('Cup&Book'),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.brown[800],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(_showFilters ? Icons.filter_alt : Icons.filter_alt_outlined),
            onPressed: () {
              setState(() {
                _showFilters = !_showFilters;
              });
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: Colors.brown[50],
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search books...',
                prefixIcon: const Icon(Icons.search, size: 20),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          _loadBooks();
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                if (value.isEmpty) {
                  _loadBooks();
                } else {
                  _searchBooks(value);
                }
              },
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Filters Panel
          if (_showFilters) _buildFiltersPanel(),

          // Results
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredBooks.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.search_off, size: 64, color: Colors.grey),
                            const SizedBox(height: 16),
                            const Text('No books found'),
                            if (_selectedAgeRange != null ||
                                _selectedGenres.isNotEmpty)
                              TextButton(
                                onPressed: _clearFilters,
                                child: const Text('Clear filters'),
                              ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _filteredBooks.length,
                        itemBuilder: (context, index) {
                          return _BookCard(book: _filteredBooks[index]);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersPanel() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.brown[50],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Age Range
          const Text('Age Range', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: AgeRange.values.map((age) {
              final isSelected = _selectedAgeRange == age;
              return ChoiceChip(
                label: Text(age.label),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _selectedAgeRange = selected ? age : null;
                  });
                  _applyFilters();
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 16),

          // Genres
          const Text('Genres', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: Genre.values.map((genre) {
              final isSelected = _selectedGenres.contains(genre);
              return FilterChip(
                label: Text(genre.label),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedGenres.add(genre);
                    } else {
                      _selectedGenres.remove(genre);
                    }
                  });
                  _applyFilters();
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 16),

          // Rating Sliders
          const Text('Content Filters',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _buildSlider('Violence', _maxViolence, (v) {
            setState(() => _maxViolence = v.round());
            _applyFilters();
          }),
          _buildSlider('Profanity', _maxProfanity, (v) {
            setState(() => _maxProfanity = v.round());
            _applyFilters();
          }),
          _buildSlider('Sexual', _maxSexual, (v) {
            setState(() => _maxSexual = v.round());
            _applyFilters();
          }),
          _buildSlider('Scary', _maxScary, (v) {
            setState(() => _maxScary = v.round());
            _applyFilters();
          }),
          _buildSlider('Mature', _maxMature, (v) {
            setState(() => _maxMature = v.round());
            _applyFilters();
          }),

          const SizedBox(height: 8),
          Center(
            child: TextButton(
              onPressed: _clearFilters,
              child: const Text('Clear All Filters'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider(String label, int value, Function(double) onChanged) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text('$label: $value'),
        ),
        Expanded(
          child: Slider(
            value: value.toDouble(),
            min: 0,
            max: 5,
            divisions: 5,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  void _searchBooks(String query) {
    final lowerQuery = query.toLowerCase();
    setState(() {
      _filteredBooks = _books.where((book) {
        return book.title.toLowerCase().contains(lowerQuery) ||
            book.author.toLowerCase().contains(lowerQuery);
      }).toList();
    });
  }
}

class _BookCard extends StatelessWidget {
  final Book book;

  const _BookCard({required this.book});

  @override
  Widget build(BuildContext context) {
    final rating = book.rating;

    // Determine color status
    Color statusColor = Colors.green;
    if (rating.averageRating > 3) {
      statusColor = Colors.yellow[700]!;
    }
    if (rating.averageRating > 4) {
      statusColor = Colors.red;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetailScreen(book: book),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cover
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: book.coverImageUrl != null
                    ? Image.network(
                        book.coverImageUrl!,
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
              const SizedBox(width: 16),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      book.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Author
                    Text(
                      book.author,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Age Range Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.brown[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        book.ageRange.label,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Ratings
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        _RatingChip(
                            label: 'V',
                            value: rating.violence.value,
                            color: _getColor(rating.violence.value)),
                        _RatingChip(
                            label: 'P',
                            value: rating.profanity.value,
                            color: _getColor(rating.profanity.value)),
                        _RatingChip(
                            label: 'S',
                            value: rating.sexualContent.value,
                            color: _getColor(rating.sexualContent.value)),
                        _RatingChip(
                            label: 'Sc',
                            value: rating.scaryThemes.value,
                            color: _getColor(rating.scaryThemes.value)),
                        _RatingChip(
                            label: 'M',
                            value: rating.matureTopics.value,
                            color: _getColor(rating.matureTopics.value)),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Community rating
                    if (book.communityRating > 0)
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                          Text(' ${book.communityRating}/5'),
                          const SizedBox(width: 8),
                          Text(
                            '(${book.reviewCount} reviews)',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
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

class _RatingChip extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const _RatingChip({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '$label:$value',
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}