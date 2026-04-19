import 'package:flutter/material.dart';
import 'package:readify_app/features/book_details/presentation/widgets/book_top_bar.dart';
// import 'package:readify_app/shared/widgets/search_bar.dart';
// import '../../../../core/theme/app_colors.dart';
import '../../data/book_repository.dart';
import '../widgets/book_hero_section.dart';
import '../widgets/book_action_section.dart';
import '../widgets/book_about_section.dart';
import '../widgets/book_publisher_section.dart';
// import '../widgets/book_shelf_section.dart';
// import '../widgets/recently_reduced_section.dart';
import '../widgets/book_reviews_section.dart';
// import '../widgets/book_bottom_nav.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = BookRepository.instance;
    final book = repo.mainBook;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ── Scrollable Body ──────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //Book Top Bar
                    BookTopBar(),
                    // Cover
                    BookHeroSection(book: book),
                    // Title / Author / Date
                    BookInfoSection(book: book),
                    _divider(),
                    // Rating | Pages | EBook
                    BookStatsRow(book: book),
                    _divider(),
                    // Buy + Wishlist + Library + Read + Write Review
                    BookActionSection(book: book),
                    _divider(),
                    // About this eBook
                    BookAboutSection(book: book),
                    _divider(),
                    // 📚 More by Author
                    // BookShelfSection(
                    //   title: '📚 More by ${book.author}',
                    //   books: repo.moreByAuthor,
                    // ),
                    // _divider(),
                    // // 🔁 Similar Books
                    // BookShelfSection(
                    //   title: '🔁 Similar Books',
                    //   books: repo.similarBooks,
                    // ),
                    _divider(),
                    // // ⭐ Featured Books
                    // BookShelfSection(
                    //   title: '⭐ Featured Books',
                    //   books: repo.featuredBooks,
                    // ),
                    // _divider(),
                    // 💸 Recently Reduced
                    // RecentlyReducedSection(books: repo.recentlyReduced),
                    _divider(),
                    // Reviews
                    BookReviewsSection(book: book, reviews: repo.reviews),
                    _divider(),
                    // Publisher Info
                    BookPublisherSection(book: book),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // ── Bottom Nav ─────────────────────────────────────────────────
    );
  }

  Widget _divider() =>
      const Divider(height: 1, thickness: 1, color: Color(0xFFEEEAE4));
}
