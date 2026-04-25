import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ─── Data Models ────────────────────────────────────────────────────────────

class Book {
  final String id;
  final String title;
  final String author;
  final String coverColor;
  final String accentColor;
  final double rating;
  final int reviewCount;
  final int pages;
  final String publishDate;
  final String genre;
  final double price;
  final double? originalPrice;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.coverColor,
    required this.accentColor,
    required this.rating,
    required this.reviewCount,
    required this.pages,
    required this.publishDate,
    required this.genre,
    required this.price,
    this.originalPrice,
  });
}

class Review {
  final String name;
  final String initials;
  final double rating;
  final String comment;
  final String date;
  final Color avatarColor;

  const Review({
    required this.name,
    required this.initials,
    required this.rating,
    required this.comment,
    required this.date,
    required this.avatarColor,
  });
}

// ─── Sample Data ─────────────────────────────────────────────────────────────

final Book mainBook = Book(
  id: '1',
  title: 'The Midnight Library',
  author: 'Matt Haig',
  coverColor: '1A1A2E',
  accentColor: 'E8A838',
  rating: 4.7,
  reviewCount: 12843,
  pages: 304,
  publishDate: 'September 29, 2020',
  genre: 'Literary Fiction',
  price: 14.99,
);

final List<Review> reviews = [
  Review(
    name: 'Sarah Mitchell',
    initials: 'SM',
    rating: 5,
    comment:
        'An absolutely breathtaking read. Haig weaves philosophy and emotion into a story that feels deeply personal. I finished it in one sitting and cried twice.',
    date: '3 days ago',
    avatarColor: Color(0xFF6C63FF),
  ),
  Review(
    name: 'James Okafor',
    initials: 'JO',
    rating: 4,
    comment:
        'A thought-provoking exploration of regret and possibility. The concept is brilliant — what if you could try every life you could have lived?',
    date: '1 week ago',
    avatarColor: Color(0xFF43B89C),
  ),
  Review(
    name: 'Priya Sharma',
    initials: 'PS',
    rating: 5,
    comment:
        'This book changed how I think about my own choices. Beautifully written, deeply moving. Matt Haig at his absolute best.',
    date: '2 weeks ago',
    avatarColor: Color(0xFFE8A838),
  ),
];

final List<Book> moreByAuthor = [
  Book(
    id: '2',
    title: 'Reasons to Stay Alive',
    author: 'Matt Haig',
    coverColor: '2D6A4F',
    accentColor: '52B788',
    rating: 4.6,
    reviewCount: 8920,
    pages: 256,
    publishDate: '2015',
    genre: 'Memoir',
    price: 12.99,
  ),
  Book(
    id: '3',
    title: 'How to Stop Time',
    author: 'Matt Haig',
    coverColor: '3D405B',
    accentColor: 'F2CC8F',
    rating: 4.4,
    reviewCount: 6340,
    pages: 336,
    publishDate: '2017',
    genre: 'Historical Fiction',
    price: 13.99,
  ),
  Book(
    id: '4',
    title: 'The Humans',
    author: 'Matt Haig',
    coverColor: '5C4033',
    accentColor: 'E07A5F',
    rating: 4.5,
    reviewCount: 7120,
    pages: 285,
    publishDate: '2013',
    genre: 'Sci-Fi',
    price: 11.99,
  ),
];

final List<Book> similarBooks = [
  Book(
    id: '5',
    title: 'A Little Life',
    author: 'Hanya Yanagihara',
    coverColor: '1B1B2F',
    accentColor: 'C77DFF',
    rating: 4.8,
    reviewCount: 15600,
    pages: 720,
    publishDate: '2015',
    genre: 'Literary Fiction',
    price: 16.99,
  ),
  Book(
    id: '6',
    title: 'Eleanor Oliphant',
    author: 'Gail Honeyman',
    coverColor: '2C3E50',
    accentColor: '3498DB',
    rating: 4.5,
    reviewCount: 11230,
    pages: 327,
    publishDate: '2017',
    genre: 'Contemporary',
    price: 13.49,
  ),
  Book(
    id: '7',
    title: 'The Alchemist',
    author: 'Paulo Coelho',
    coverColor: '7B3F00',
    accentColor: 'F4A261',
    rating: 4.6,
    reviewCount: 22000,
    pages: 197,
    publishDate: '1988',
    genre: 'Philosophy',
    price: 10.99,
  ),
];

final List<Book> featuredBooks = [
  Book(
    id: '8',
    title: 'Demon Copperhead',
    author: 'Barbara Kingsolver',
    coverColor: '4A1942',
    accentColor: 'FF6B9D',
    rating: 4.7,
    reviewCount: 9800,
    pages: 560,
    publishDate: '2022',
    genre: 'Literary Fiction',
    price: 17.99,
  ),
  Book(
    id: '9',
    title: 'Tomorrow, Tomorrow',
    author: 'Jonathan Coe',
    coverColor: '0D3B66',
    accentColor: 'FAF0CA',
    rating: 4.3,
    reviewCount: 4200,
    pages: 416,
    publishDate: '2023',
    genre: 'Contemporary',
    price: 15.99,
  ),
];

final List<Book> recentlyReduced = [
  Book(
    id: '10',
    title: 'Pachinko',
    author: 'Min Jin Lee',
    coverColor: '1A3A4A',
    accentColor: 'FF9F1C',
    rating: 4.8,
    reviewCount: 18400,
    pages: 496,
    publishDate: '2017',
    genre: 'Historical Fiction',
    price: 7.99,
    originalPrice: 15.99,
  ),
  Book(
    id: '11',
    title: 'Normal People',
    author: 'Sally Rooney',
    coverColor: '3C1518',
    accentColor: 'E63946',
    rating: 4.3,
    reviewCount: 13700,
    pages: 273,
    publishDate: '2018',
    genre: 'Romance',
    price: 6.99,
    originalPrice: 12.99,
  ),
  Book(
    id: '12',
    title: 'Educated',
    author: 'Tara Westover',
    coverColor: '2B4141',
    accentColor: '84A98C',
    rating: 4.7,
    reviewCount: 21000,
    pages: 352,
    publishDate: '2018',
    genre: 'Memoir',
    price: 8.49,
    originalPrice: 14.99,
  ),
];

// ─── Main Screen ─────────────────────────────────────────────────────────────

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({super.key});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen>
    with TickerProviderStateMixin {
  bool _isWishlisted = false;
  bool _isInLibrary = false;
  bool _descriptionExpanded = false;
  late ScrollController _scrollController;
  late AnimationController _heartController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  double _scrollOffset = 0;

  static const Color _bg = Color(0xFF0F0F1A);
  static const Color _surface = Color(0xFF1A1A2E);
  static const Color _card = Color(0xFF16213E);
  static const Color _accent = Color(0xFF2D6A65);
  static const Color _accentSoft = Color(0x33E8A838);
  static const Color _textPrimary = Color(0xFFF5F0E8);
  static const Color _textSecondary = Color(0xFF9B9BB4);
  static const Color _divider = Color(0xFF2A2A45);

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() => _scrollOffset = _scrollController.offset);
    });
    _heartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _heartController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(child: _buildHeroSection()),
            SliverToBoxAdapter(child: _buildQuickStats()),
            SliverToBoxAdapter(child: _buildActionButtons()),
            SliverToBoxAdapter(child: _buildDescription()),
            SliverToBoxAdapter(child: _buildPublisherInfo()),
            SliverToBoxAdapter(child: _buildReviewsSection()),
            SliverToBoxAdapter(
              child: _buildHorizontalSection(
                icon: '📚',
                title: 'More by Matt Haig',
                books: moreByAuthor,
              ),
            ),
            SliverToBoxAdapter(
              child: _buildHorizontalSection(
                icon: '🔁',
                title: 'Similar Books',
                books: similarBooks,
              ),
            ),
            SliverToBoxAdapter(
              child: _buildHorizontalSection(
                icon: '⭐',
                title: 'Featured Books',
                books: featuredBooks,
              ),
            ),
            SliverToBoxAdapter(child: _buildReducedSection()),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  // ── AppBar ────────────────────────────────────────────────────────────────

  PreferredSizeWidget _buildAppBar() {
    final double opacity = (_scrollOffset / 200).clamp(0.0, 1.0);
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _surface.withOpacity(0.8),
            shape: BoxShape.circle,
            border: Border.all(color: _divider),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 16,
            color: _textPrimary,
          ),
        ),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: _divider),
            ),
            child: const Icon(
              Icons.share_outlined,
              size: 16,
              color: _textPrimary,
            ),
          ),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  // ── Hero ─────────────────────────────────────────────────────────────────

  Widget _buildHeroSection() {
    return SizedBox(
      height: 480,
      child: Stack(
        children: [
          // Background glow
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [_accent.withOpacity(0.15), Colors.transparent],
                  ),
                ),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 100, 24, 0),
            child: Column(
              children: [
                // Book Cover
                _buildBookCover(mainBook, size: 'large'),
                const SizedBox(height: 24),
                // Genre tag
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _accentSoft,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: _accent.withOpacity(0.3)),
                  ),
                  child: Text(
                    mainBook.genre.toUpperCase(),
                    style: const TextStyle(
                      color: _accent,
                      fontSize: 10,
                      fontFamily: 'Georgia',
                      letterSpacing: 2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Title
                Text(
                  mainBook.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: _textPrimary,
                    fontSize: 26,
                    fontFamily: 'Georgia',
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                // Author
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'by ',
                      style: TextStyle(
                        color: _textSecondary,
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Text(
                      mainBook.author,
                      style: const TextStyle(
                        color: _accent,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                // Rating row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(
                      5,
                      (i) => Icon(
                        i < 4 ? Icons.star_rounded : Icons.star_half_rounded,
                        color: _accent,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      mainBook.rating.toString(),
                      style: const TextStyle(
                        color: _textPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '(${_formatCount(mainBook.reviewCount)} reviews)',
                      style: const TextStyle(
                        color: _textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookCover(Book book, {String size = 'small'}) {
    final double w = size == 'large' ? 140 : 85;
    final double h = size == 'large' ? 200 : 122;
    final Color bg = _hexColor(book.coverColor);
    final Color acc = _hexColor(book.accentColor);

    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size == 'large' ? 12 : 8),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [bg, Color.lerp(bg, Colors.black, 0.4)!],
        ),
        boxShadow: [
          BoxShadow(
            color: acc.withOpacity(0.25),
            blurRadius: size == 'large' ? 30 : 14,
            offset: const Offset(0, 8),
            spreadRadius: size == 'large' ? 2 : 0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Spine line
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: 6,
            child: Container(
              decoration: BoxDecoration(
                color: acc.withOpacity(0.6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(size == 'large' ? 12 : 8),
                  bottomLeft: Radius.circular(size == 'large' ? 12 : 8),
                ),
              ),
            ),
          ),
          // Inner design
          Positioned.fill(
            left: 6,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 2,
                    width: double.infinity,
                    color: acc.withOpacity(0.5),
                  ),
                  const SizedBox(height: 6),
                  if (size == 'large') ...[
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: acc.withOpacity(0.1),
                        border: Border.all(
                          color: acc.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        Icons.auto_stories,
                        color: acc.withOpacity(0.6),
                        size: 28,
                      ),
                    ),
                    const Spacer(),
                  ] else
                    const Spacer(),
                  Text(
                    book.title,
                    maxLines: size == 'large' ? 3 : 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: _textPrimary.withOpacity(0.9),
                      fontSize: size == 'large' ? 11 : 8,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(height: 1, color: acc.withOpacity(0.3)),
                  const SizedBox(height: 4),
                  Text(
                    book.author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: acc.withOpacity(0.8),
                      fontSize: size == 'large' ? 9 : 7,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Quick Stats ───────────────────────────────────────────────────────────

  Widget _buildQuickStats() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 4),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _divider),
      ),
      child: Row(
        children: [
          _statItem(Icons.menu_book_outlined, '${mainBook.pages}', 'Pages'),
          _verticalDivider(),
          _statItem(Icons.calendar_today_outlined, '2020', 'Published'),
          _verticalDivider(),
          _statItem(Icons.star_outline_rounded, '${mainBook.rating}', 'Rating'),
          _verticalDivider(),
          _statItem(Icons.language_outlined, 'English', 'Language'),
        ],
      ),
    );
  }

  Widget _statItem(IconData icon, String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: _accent, size: 20),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: _textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(color: _textSecondary, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _verticalDivider() => Container(height: 40, width: 1, color: _divider);

  // ── Action Buttons ────────────────────────────────────────────────────────

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Column(
        children: [
          // Primary actions
          Row(
            children: [
              // Wishlist
              GestureDetector(
                onTap: () {
                  setState(() => _isWishlisted = !_isWishlisted);
                  if (_isWishlisted) {
                    _heartController.forward(from: 0);
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: _isWishlisted
                        ? const Color(0xFFE63946).withOpacity(0.15)
                        : _card,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: _isWishlisted
                          ? const Color(0xFFE63946).withOpacity(0.4)
                          : _divider,
                    ),
                  ),
                  child: Icon(
                    _isWishlisted
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: _isWishlisted
                        ? const Color(0xFFE63946)
                        : _textSecondary,
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Add to Library
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _isInLibrary = !_isInLibrary),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    height: 52,
                    decoration: BoxDecoration(
                      color: _isInLibrary ? _accentSoft : _card,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: _isInLibrary ? _accent : _divider,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _isInLibrary
                              ? Icons.check_circle_rounded
                              : Icons.add_circle_outline_rounded,
                          color: _isInLibrary ? _accent : _textSecondary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _isInLibrary ? 'In Library' : 'Add to Library',
                          style: TextStyle(
                            color: _isInLibrary ? _accent : _textSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Read / Buy row
          Row(
            children: [
              Expanded(
                child: _primaryButton(
                  icon: Icons.menu_book_rounded,
                  label: 'Read Now',
                  filled: true,
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _primaryButton(
                  icon: Icons.shopping_cart_outlined,
                  label: '\$${mainBook.price}',
                  filled: false,
                  onTap: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Write Review
          GestureDetector(
            onTap: () => _showWriteReviewSheet(),
            child: Container(
              width: double.infinity,
              height: 46,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _divider),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.rate_review_outlined,
                    color: _textSecondary,
                    size: 18,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Write a Review',
                    style: TextStyle(
                      color: _textSecondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _primaryButton({
    required IconData icon,
    required String label,
    required bool filled,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          gradient: filled
              ? const LinearGradient(
                  colors: [Color(0xFFE8A838), Color(0xFFD4910A)],
                )
              : null,
          color: filled ? null : _card,
          borderRadius: BorderRadius.circular(14),
          border: filled ? null : Border.all(color: _accent.withOpacity(0.4)),
          boxShadow: filled
              ? [
                  BoxShadow(
                    color: _accent.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: filled ? const Color(0xFF1A1A2E) : _accent,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: filled ? const Color(0xFF1A1A2E) : _accent,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Description ───────────────────────────────────────────────────────────

  Widget _buildDescription() {
    const description =
        'Somewhere out beyond the edge of the universe there is a library that contains an infinite number of books, each one the story of another reality. One tells the story of your life as it is, along with another book for the other life you could have lived if you had made a different choice at any point in your life. While we all wonder how our lives might have been, what if you had the chance to go to the library and see for yourself?\n\nBetween life and death there is a library, and within that library, the shelves go on forever. Every book provides a chance to try another life you could have lived. To see how things would be if you had made other choices. Would you have done anything different, if you had the chance to undo your regrets?';

    final displayText = _descriptionExpanded
        ? description
        : '${description.substring(0, 200)}...';

    return _section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('About this Book'),
          const SizedBox(height: 12),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: _descriptionExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: Text(
              '${description.substring(0, 200)}...',
              style: const TextStyle(
                color: _textSecondary,
                fontSize: 14,
                height: 1.7,
              ),
            ),
            secondChild: Text(
              description,
              style: const TextStyle(
                color: _textSecondary,
                fontSize: 14,
                height: 1.7,
              ),
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () =>
                setState(() => _descriptionExpanded = !_descriptionExpanded),
            child: Text(
              _descriptionExpanded ? 'Show less' : 'Read more',
              style: const TextStyle(
                color: _accent,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Publisher Info ────────────────────────────────────────────────────────

  Widget _buildPublisherInfo() {
    return _section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Publisher Information'),
          const SizedBox(height: 12),
          _infoRow('Publisher', 'Viking / Penguin Books'),
          _infoRow('Publication Date', mainBook.publishDate),
          _infoRow('Pages', '${mainBook.pages}'),
          _infoRow('Language', 'English'),
          _infoRow('ISBN-13', '978-0525559474'),
          _infoRow('Genre', mainBook.genre),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(color: _textSecondary, fontSize: 13),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: _textPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Reviews ───────────────────────────────────────────────────────────────

  Widget _buildReviewsSection() {
    return _section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _sectionTitle('Reviews'),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'See all',
                  style: TextStyle(color: _accent, fontSize: 13),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Overall rating bar
          _buildRatingOverview(),
          const SizedBox(height: 16),
          // Review cards
          ...reviews.map((r) => _buildReviewCard(r)),
        ],
      ),
    );
  }

  Widget _buildRatingOverview() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _divider),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                mainBook.rating.toString(),
                style: const TextStyle(
                  color: _textPrimary,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Georgia',
                ),
              ),
              Row(
                children: List.generate(
                  5,
                  (i) => Icon(
                    i < 4 ? Icons.star_rounded : Icons.star_half_rounded,
                    color: _accent,
                    size: 14,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _formatCount(mainBook.reviewCount),
                style: const TextStyle(color: _textSecondary, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              children: [
                _ratingBar(5, 0.72),
                _ratingBar(4, 0.18),
                _ratingBar(3, 0.07),
                _ratingBar(2, 0.02),
                _ratingBar(1, 0.01),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _ratingBar(int stars, double fraction) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            '$stars',
            style: const TextStyle(color: _textSecondary, fontSize: 11),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: fraction,
                backgroundColor: _divider,
                valueColor: const AlwaysStoppedAnimation<Color>(_accent),
                minHeight: 6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Review review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: review.avatarColor.withOpacity(0.2),
                child: Text(
                  review.initials,
                  style: TextStyle(
                    color: review.avatarColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.name,
                    style: const TextStyle(
                      color: _textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      ...List.generate(
                        review.rating.toInt(),
                        (i) => const Icon(
                          Icons.star_rounded,
                          color: _accent,
                          size: 11,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        review.date,
                        style: const TextStyle(
                          color: _textSecondary,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.more_horiz, color: _textSecondary, size: 18),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            review.comment,
            style: const TextStyle(
              color: _textSecondary,
              fontSize: 13,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  // ── Book Sections ─────────────────────────────────────────────────────────

  Widget _buildHorizontalSection({
    required String icon,
    required String title,
    required List<Book> books,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
          child: Row(
            children: [
              Text('$icon ', style: const TextStyle(fontSize: 18)),
              Text(
                title,
                style: const TextStyle(
                  color: _textPrimary,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Georgia',
                ),
              ),
              const Spacer(),
              const Text(
                'See all',
                style: TextStyle(color: _accent, fontSize: 12),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: books.length,
            itemBuilder: (context, i) => _bookCard(books[i]),
          ),
        ),
      ],
    );
  }

  Widget _bookCard(Book book) {
    return Container(
      width: 110,
      margin: const EdgeInsets.only(right: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBookCover(book),
          const SizedBox(height: 8),
          Text(
            book.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: _textPrimary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            book.author,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: _textSecondary, fontSize: 10),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.star_rounded, color: _accent, size: 11),
              const SizedBox(width: 2),
              Text(
                book.rating.toString(),
                style: const TextStyle(color: _textSecondary, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Recently Reduced ──────────────────────────────────────────────────────

  Widget _buildReducedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
          child: Row(
            children: [
              const Text('💸 ', style: TextStyle(fontSize: 18)),
              const Text(
                'Recently Reduced',
                style: TextStyle(
                  color: _textPrimary,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Georgia',
                ),
              ),
              const Spacer(),
              const Text(
                'See all',
                style: TextStyle(color: _accent, fontSize: 12),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: recentlyReduced.length,
          itemBuilder: (context, i) => _reducedBookRow(recentlyReduced[i]),
        ),
      ],
    );
  }

  Widget _reducedBookRow(Book book) {
    final discount = book.originalPrice != null
        ? ((1 - book.price / book.originalPrice!) * 100).round()
        : 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _divider),
      ),
      child: Row(
        children: [
          _buildBookCover(book),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  book.author,
                  style: const TextStyle(color: _textSecondary, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '\$${book.price}',
                      style: const TextStyle(
                        color: _accent,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (book.originalPrice != null)
                      Text(
                        '\$${book.originalPrice}',
                        style: const TextStyle(
                          color: _textSecondary,
                          fontSize: 12,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D6A4F).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFF52B788).withOpacity(0.4),
                  ),
                ),
                child: Text(
                  '-$discount%',
                  style: const TextStyle(
                    color: Color(0xFF52B788),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2D6A65), Color(0xFF2D6A65)],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Buy',
                    style: TextStyle(
                      color: Color(0xFF1A1A2E),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Bottom Bar ────────────────────────────────────────────────────────────

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      decoration: BoxDecoration(
        color: _surface,
        border: const Border(top: BorderSide(color: _divider)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Price',
                style: TextStyle(color: _textSecondary, fontSize: 11),
              ),
              Text(
                '\$${mainBook.price}',
                style: const TextStyle(
                  color: _accent,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Georgia',
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2D6A65), Color(0xFF2D6A65)],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: _accent.withOpacity(0.35),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_rounded,
                      color: Color(0xFF1A1A2E),
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Buy Now',
                      style: TextStyle(
                        color: Color(0xFF1A1A2E),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Write Review Sheet ────────────────────────────────────────────────────

  void _showWriteReviewSheet() {
    int selectedRating = 0;
    final controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: _surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (ctx, setModalState) => Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: _divider,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Write a Review',
                style: TextStyle(
                  color: _textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Georgia',
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Your rating',
                style: TextStyle(color: _textSecondary, fontSize: 13),
              ),
              const SizedBox(height: 8),
              Row(
                children: List.generate(5, (i) {
                  return GestureDetector(
                    onTap: () => setModalState(() => selectedRating = i + 1),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(
                        i < selectedRating
                            ? Icons.star_rounded
                            : Icons.star_outline_rounded,
                        color: _accent,
                        size: 34,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                maxLines: 4,
                style: const TextStyle(color: _textPrimary, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Share your thoughts about this book...',
                  hintStyle: const TextStyle(
                    color: _textSecondary,
                    fontSize: 14,
                  ),
                  filled: true,
                  fillColor: _card,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: _divider),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: _divider),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: _accent),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _accent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Submit Review',
                    style: TextStyle(
                      color: Color(0xFF1A1A2E),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  Widget _section({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _divider),
        ),
        child: child,
      ),
    );
  }

  Widget _sectionTitle(String title) => Text(
    title,
    style: const TextStyle(
      color: _textPrimary,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily: 'Georgia',
    ),
  );

  String _formatCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }

  Color _hexColor(String hex) {
    return Color(int.parse('FF$hex', radix: 16));
  }
}
