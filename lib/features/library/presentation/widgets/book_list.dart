import 'package:flutter/material.dart';
import 'package:readify_app/features/library/domain/entities/book_model.dart';
import 'package:readify_app/features/library/presentation/widgets/book_list_item.dart';

class BookList extends StatelessWidget {
  const BookList({
    super.key,
    required this.books,
    required this.primaryColor,
  });

  final List<BookModel> books;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: books.length,
      separatorBuilder: (_, _) =>
          Divider(color: Colors.grey.shade200, height: 1),
      itemBuilder: (context, index) {
        final book = books[index];
        return BookListItem(
          title: book.title,
          author: book.author,
          progressPercent: book.progressPercent,
          primaryColor: primaryColor,
          coverUrl: book.coverUrl,
          onDownloadTap: () {
            // TODO: handle download
          },
        );
      },
    );
  }
}