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
import 'package:readify_app/features/book_details/presentation/screens/book_details_screen.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  static String routeName = '/home';

  const HomeScreen({super.key, required this.title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeRepositoryImpl _repo;
  late final Future<List<FeaturedBookModel>> _featuredBooks;
  late final Future<List<RecentBooksModel>> _recentBooks;
  late final Future<List<TopSellingBookModel>> _topSellingBooks;
  late final Future<List<FreeBookModel>> _freeBooks;

  @override
  void initState() {
    super.initState();
    _repo = HomeRepositoryImpl(remoteDataSource: HomeRemoteDataSource());
    _loadData();
  }

  void _loadData() {
    setState(() {
      _featuredBooks = _repo.getFeaturedBooks();
      _recentBooks = _repo.getRecentBooks();
      _topSellingBooks = _repo.getTopSellingBooks();
      _freeBooks = _repo.getFreeBooks();
    });
  }

  Widget _buildErrorWidget(String error, VoidCallback onRetry) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: Colors.grey[400]),
          const SizedBox(height: 12),
          Text(
            'Something went wrong',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh, size: 18),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Container(
              width: 120,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.book_outlined, size: 48, color: Colors.grey[400]),
          const SizedBox(height: 12),
          Text(
            'No books available',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildBookSection<T>(
    String title,
    Future<List<T>> future,
    List<Map<String, dynamic>> Function(List<T>) mapBooks,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: title),
        FutureBuilder<List<T>>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildLoadingShimmer();
            }
            if (snapshot.hasError) {
              return _buildErrorWidget(snapshot.error.toString(), _loadData);
            }
            if (snapshot.data?.isEmpty ?? true) {
              return _buildEmptyState();
            }
            final books = mapBooks(snapshot.data!);
            return HorizontalBookList(
              books: books,
              onBookTap: (int bookId) =>
                  _navigateToBookDetails(bookId),
            );
          },
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }

  void _navigateToBookDetails(int bookId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsScreen(
          bookId: bookId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F8),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16.0),
                    const SearchBarWidget(),
                    const SizedBox(height: 25.0),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildBookSection(
                  'Featured Books',
                  _featuredBooks,
                  (books) => books
                      .map(
                        (b) => {
                          'id': b.id,
                          'title': b.title,
                          'author': '${b.authorFirstName} ${b.authorLastName}',
                          'price': '\$${b.price.toStringAsFixed(2)}',
                          'coverUrl': b.coverUrl,
                        },
                      )
                      .toList(),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildBookSection(
                  'Recently Reduced eBooks',
                  _recentBooks,
                  (books) => books
                      .map(
                        (b) => {
                          'id': b.id,
                          'title': b.title,
                          'author': '${b.authorFirstName} ${b.authorLastName}',
                          'price': '\$${b.price.toStringAsFixed(2)}',
                          'coverUrl': b.coverUrl,
                        },
                      )
                      .toList(),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildBookSection(
                  'Top-Selling Books',
                  _topSellingBooks,
                  (books) => books
                      .map(
                        (b) => {
                          'id': b.id,
                          'title': b.title,
                          'author': '${b.authorFirstName} ${b.authorLastName}',
                          'price': '\$${b.price.toStringAsFixed(2)}',
                          'coverUrl': b.coverUrl,
                        },
                      )
                      .toList(),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildBookSection(
                  'Popular Free Books',
                  _freeBooks,
                  (books) => books
                      .map(
                        (b) => {
                          'id': b.id,
                          'title': b.title,
                          'author': '${b.authorFirstName} ${b.authorLastName}',
                          'price': '\$${b.price.toStringAsFixed(2)}',
                          'coverUrl': b.coverUrl,
                        },
                      )
                      .toList(),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
