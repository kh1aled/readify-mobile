import 'package:flutter/material.dart';
import 'package:readify_app/shared/widgets/search_bar.dart';
import 'package:readify_app/features/library/domain/entities/book_model.dart';
import 'package:readify_app/features/library/presentation/widgets/book_list.dart';
import 'package:readify_app/features/library/presentation/widgets/library_sort_row.dart';
import 'package:readify_app/features/library/presentation/widgets/library_tab_bar.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  int _selectedTab = 0;

  final List<String> _tabs = ['Reading', 'Completed', 'Wishlist'];

  final List<BookModel> _books = List.generate(
    8,
    (_) => const BookModel(
      title: 'Essentialism',
      author: 'Greg McKeown',
      progressPercent: 34,
      coverUrl: 'assets/images/books/book1.png',
    ),
  );

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F8),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16.0),
                  const SearchBarWidget(),
                  const SizedBox(height: 16.0),
                  LibraryTabBar(
                    tabs: _tabs,
                    selectedIndex: _selectedTab,
                    onTabSelected: (i) => setState(() => _selectedTab = i),
                    primaryColor: primary,
                  ),
                  const SizedBox(height: 16.0),
                  const LibrarySortRow(),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
            Expanded(
              child: BookList(books: _books, primaryColor: primary),
            ),
          ],
        ),
      ),
    );
  }
}