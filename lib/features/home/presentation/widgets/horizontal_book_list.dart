import 'package:flutter/material.dart';
import 'package:readify_app/features/home/presentation/widgets/book_card.dart';

class HorizontalBookList extends StatelessWidget {
  final List<Map<String, dynamic>> books;
  final double height;

  const HorizontalBookList({
    super.key,
    required this.books,
    this.height = 290,
  });

  @override
  Widget build(BuildContext context) {
    if (books.isEmpty) {
      return SizedBox(
        height: height,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.library_books_outlined,
                  size: 40, color: Colors.grey[300]),
              const SizedBox(height: 8),
              Text(
                'No books available',
                style: TextStyle(fontSize: 14, color: Colors.grey[400]),
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
        itemCount: books.length,
        itemBuilder: (_, index) {
          final book = books[index];
          return BookCard(
            title: book['title'] ?? 'Untitled',
            author: book['author'] ?? 'Unknown Author',
            coverUrl: book['coverUrl'] ??
                'assets/images/default_book_cover.png',
            price: book['price'] ?? 'N/A',
            onTap: () {
              // TODO: navigate to book detail
            },
          );
        },
        separatorBuilder: (_, _) => const SizedBox(width: 10),
      ),
    );
  }
}