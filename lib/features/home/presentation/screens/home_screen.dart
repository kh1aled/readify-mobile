import 'package:flutter/material.dart';
import 'package:readify_app/features/home/data/home_remote_data_source.dart';
import 'package:readify_app/features/home/data/home_repository_impl.dart';
import 'package:readify_app/features/home/domain/featured_books_model.dart';
import 'package:readify_app/features/home/domain/free_book_model.dart';
import 'package:readify_app/features/home/domain/recent_books_model.dart';
import 'package:readify_app/features/home/domain/top_selling_book_model.dart';
import 'package:readify_app/features/home/presentation/widgets/category_list.dart';
import 'package:readify_app/features/home/presentation/widgets/horizontal_book_list.dart';
import 'package:readify_app/shared/widgets/search_bar.dart';
import 'package:readify_app/features/home/presentation/widgets/section_header.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  static String routeName = '/home';

  const HomeScreen({super.key, required this.title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ─── Featured Books ────────────────────────────────────────────────────────
  late final Future<List<FeaturedBookModel>> _featuredBooks;

  // ─── Recently Reduced eBooks ───────────────────────────────────────────────
  late final Future<List<RecentBooksModel>> _recentBooks;

  // ─── Top-Selling Books ─────────────────────────────────────────────────────
  late final Future<List<TopSellingBookModel>> _topSellingBooks;

  // ─── Popular Free Books ────────────────────────────────────────────────────
  late final Future<List<FreeBookModel>> _freeBooks;

  @override
  void initState() {
    super.initState();
    final repo = HomeRepositoryImpl(remoteDataSource: HomeRemoteDataSource());
    _featuredBooks = repo.getFeaturedBooks();
    _recentBooks = repo.getRecentBooks();
    _topSellingBooks = repo.getTopSellingBooks();
    _freeBooks = repo.getFreeBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F8),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16.0),
                    const SearchBarWidget(),
                    const SizedBox(height: 25.0),

                    // ─── Featured Books ──────────────────────────────────────
                    const SectionHeader(title: 'Featured Books'),
                    FutureBuilder<List<FeaturedBookModel>>(
                      future: _featuredBooks,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        final books = snapshot.data!;
                        return HorizontalBookList(
                          books: books
                              .map(
                                (b) => {
                                  'title': b.title,
                                  'author':
                                      '${b.authorFirstName} ${b.authorLastName}',
                                  'price': '\$${b.price.toStringAsFixed(2)}',
                                  'coverUrl': b.coverUrl,
                                },
                              )
                              .toList(),
                        );
                      },
                    ),

                    const SizedBox(height: 16.0),

                    // ─── Recently Reduced eBooks ─────────────────────────────
                    const SectionHeader(title: 'Recently Reduced eBooks'),
                    FutureBuilder<List<RecentBooksModel>>(
                      future: _recentBooks,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        final books = snapshot.data!;
                        return HorizontalBookList(
                          books: books
                              .map(
                                (b) => {
                                  'title': b.title,
                                  'author':
                                      '${b.authorFirstName} ${b.authorLastName}',
                                  'price': '\$${b.price.toStringAsFixed(2)}',
                                  'coverUrl': b.coverUrl,
                                },
                              )
                              .toList(),
                        );
                      },
                    ),

                    const SizedBox(height: 16.0),

                    // ─── Top-Selling Books ───────────────────────────────────
                    const SectionHeader(title: 'Top-Selling Books'),
                    FutureBuilder<List<TopSellingBookModel>>(
                      future: _topSellingBooks,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        final books = snapshot.data!;
                        return HorizontalBookList(
                          books: books
                              .map(
                                (b) => {
                                  'title': b.title,
                                  'author':
                                      '${b.authorFirstName} ${b.authorLastName}',
                                  'price': '\$${b.price.toStringAsFixed(2)}',
                                  'coverUrl': b.coverUrl,
                                },
                              )
                              .toList(),
                        );
                      },
                    ),

                    const SizedBox(height: 16.0),

                    // ─── Popular Free Books ──────────────────────────────────
                    const SectionHeader(title: 'Popular Free Books'),
                    FutureBuilder<List<FreeBookModel>>(
                      future: _freeBooks,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        final books = snapshot.data!;
                        return HorizontalBookList(
                          books: books
                              .map(
                                (b) => {
                                  'title': b.title,
                                  'author':
                                      '${b.authorFirstName} ${b.authorLastName}',
                                  'price': '\$${b.price.toStringAsFixed(2)}',
                                  'coverUrl': b.coverUrl,
                                },
                              )
                              .toList(),
                        );
                      },
                    ),
                    const SizedBox(height: 24.0),

                    // ─── Explore ─────────────────────────────────────────────
                    const SectionHeader(title: 'Explore Play Books'),
                    CategoryList(),
                    const SizedBox(height: 25.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
