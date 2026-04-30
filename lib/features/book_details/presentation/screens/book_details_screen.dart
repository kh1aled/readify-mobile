import 'package:flutter/material.dart';
import '../../data/book_remote_data_source.dart';
import '../../domain/book_details_model.dart';
import '../widgets/book_top_bar.dart';
import '../widgets/book_hero_section.dart';
import '../widgets/book_action_section.dart';
import '../widgets/book_about_section.dart';
import '../widgets/book_publisher_section.dart';
// import '../widgets/book_reviews_section.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({super.key, required this.bookId});

  final int bookId;
  static String routeName = '/book_details';

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  late final Future<BookDetailsModel> _bookFuture;
  final _dataSource = BookRemoteDataSource();

  @override
  void initState() {
    super.initState();
    _bookFuture = _dataSource.fetchBookDetails(widget.bookId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<BookDetailsModel>(
          future: _bookFuture,
          builder: (context, snapshot) {
            // ── Loading ──────────────────────────────────────────────
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // ── Error ────────────────────────────────────────────────
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      snapshot.error.toString(),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => setState(() {
                        _bookFuture = _dataSource.fetchBookDetails(
                          widget.bookId,
                        );
                      }),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            // ── Success ──────────────────────────────────────────────
            final book = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        BookTopBar(),
                        BookHeroSection(book: book),
                        BookInfoSection(book: book),
                        _divider(),
                        BookStatsRow(book: book),
                        _divider(),
                        BookActionSection(book: book),
                        _divider(),
                        BookAboutSection(book: book),
                        _divider(),
                        // BookReviewsSection(book: book),
                        _divider(),
                        BookPublisherSection(book: book),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _divider() =>
      const Divider(height: 1, thickness: 1, color: Color(0xFFEEEAE4));
}
