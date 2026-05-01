import 'package:flutter/material.dart';
import 'package:readify_app/core/services/token_storage_service.dart';
import 'package:readify_app/features/library/data/download_service.dart';
import 'package:readify_app/features/library/domain/entities/user_book_model.dart';
import 'package:readify_app/features/library/domain/library_repository.dart';
import 'package:readify_app/features/library/presentation/widgets/book_list_item.dart';

class BookList extends StatelessWidget {
  const BookList({
    super.key,
    required this.books,
    required this.primaryColor,
    required this.downloadService,
    this.onBookTap,
  });

  final List<UserBookModel> books;
  final Color primaryColor;
  final DownloadService downloadService;
  final void Function(UserBookModel book)? onBookTap;

  @override
  Widget build(BuildContext context) {
    if (books.isEmpty) {
      return const Center(
        child: Text(
          'No books here yet',
          style: TextStyle(color: Colors.black38),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: books.length,
      separatorBuilder: (_, __) =>
          Divider(color: Colors.grey.shade200, height: 1),
      itemBuilder: (context, index) {
        return BookListItem(
          book: books[index],
          primaryColor: primaryColor,
          downloadService: downloadService,
          onTap: onBookTap != null ? () => onBookTap!(books[index]) : null,
        );
      },
    );
  }
}
