import 'package:flutter/material.dart';
import 'package:readify_app/core/services/token_storage_service.dart';
import 'package:readify_app/core/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/book_remote_data_source.dart';
import '../../domain/book_details_model.dart';
import '../widgets/book_top_bar.dart';
import '../widgets/book_hero_section.dart';
import '../widgets/book_action_section.dart';
import '../widgets/book_about_section.dart';
import '../widgets/book_publisher_section.dart';
import '../widgets/book_reviews_section.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({super.key, required this.bookId});

  final int bookId;
  static String routeName = '/book_details';

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  late Future<BookDetailsModel> _bookFuture;
  final _dataSource = BookRemoteDataSource();

  @override
  void initState() {
    super.initState();
    _bookFuture = _dataSource.fetchBookDetails(widget.bookId);
  }

  Future<void> _refreshBook() async {
    setState(() {
      _bookFuture = _dataSource.fetchBookDetails(widget.bookId);
    });
    await Future<void>.delayed(const Duration(milliseconds: 50));
  }

  void _showWriteReview(BuildContext context, int bookId) {
    int selectedRating = 0;
    bool submitting = false;
    final controller = TextEditingController();
    final dataSource = BookRemoteDataSource();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => StatefulBuilder(
        builder: (ctx, setModal) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
            left: 24,
            right: 24,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (i) => IconButton(
                    onPressed: () => setModal(() => selectedRating = i + 1),
                    icon: Icon(
                      i < selectedRating ? Icons.star : Icons.star_border,
                      color: AppColors.star,
                    ),
                  ),
                ),
              ),

              TextField(
                controller: controller,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Write your review...',
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: submitting
                      ? null
                      : () async {
                          if (selectedRating == 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select a rating'),
                              ),
                            );
                            return;
                          }

                          if (controller.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please write a comment'),
                              ),
                            );
                            return;
                          }

                          final prefs = await SharedPreferences.getInstance();
                          final tokenStorage = TokenStorageService(prefs);
                          final userId = tokenStorage.getUserId();

                          if (userId == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Login required')),
                            );
                            return;
                          }

                          setModal(() => submitting = true);

                          try {
                            await dataSource.addReview(
                              bookId,
                              userId,
                              controller.text.trim(),
                              selectedRating,
                            );

                            if (ctx.mounted) Navigator.pop(ctx);

                            await Future<void>.delayed(
                              const Duration(milliseconds: 400),
                            );

                            await _refreshBook();

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Review submitted!'),
                                ),
                              );
                            }
                          } catch (e) {
                            setModal(() => submitting = false);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error: $e')),
                              );
                            }
                          } finally {
                            controller.dispose();
                          }
                        },
                  child: submitting
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Submit Review'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
                      onPressed: _refreshBook,
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
                        const BookTopBar(),
                        BookHeroSection(book: book),
                        BookInfoSection(book: book),
                        _divider(),
                        BookStatsRow(book: book),
                        _divider(),
                        BookActionSection(
                          book: book,
                          onReviewSubmitted: _refreshBook,
                        ),

                        _divider(),
                        BookAboutSection(book: book),
                        _divider(),
                        BookReviewsSection(
                          book: book,
                          reviews: book.reviews,
                          onWriteReview: () =>
                              _showWriteReview(context, book.id),
                        ),
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
