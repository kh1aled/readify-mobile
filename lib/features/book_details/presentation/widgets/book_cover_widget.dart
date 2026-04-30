import 'package:flutter/material.dart';
import 'package:readify_app/features/book_details/domain/book_details_model.dart';
import '../../../../core/constants/app_constants.dart';

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
      ),
    );
  }
}
