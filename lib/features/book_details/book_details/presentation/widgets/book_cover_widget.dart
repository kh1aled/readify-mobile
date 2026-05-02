import 'package:flutter/material.dart';
import 'package:readify_app/core/constants/app_constants.dart';
import 'package:readify_app/features/book_details/book_details/domain/book_details_model.dart';

class BookCoverWidget extends StatelessWidget {
  final BookDetailsModel book;
  final double width;
  final double height;
  final double borderRadius;

  const BookCoverWidget({
    super.key,
    required this.book,
    this.width = AppConstants.coverWidthSmall,
    this.height = AppConstants.coverHeightSmall,
    this.borderRadius = 6,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        book.coverUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          width: width,
          height: height,
          color: const Color(0xFFE0E0E0),
          child: const Icon(Icons.book, color: Color(0xFF9E9E9E)),
        ),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: width,
            height: height,
            color: const Color(0xFFF5F5F5),
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        },
      ),
    );
  }
}
