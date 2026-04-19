import 'package:flutter/material.dart';
import 'package:readify_app/features/book_details/domain/entities.dart';
import '../../../../core/constants/app_constants.dart';

class BookCoverWidget extends StatelessWidget {
  final BookEntity book;
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

  const BookCoverWidget.main({
    super.key,
    required this.book,
    this.width = AppConstants.coverWidthMain,
    this.height = AppConstants.coverHeightMain,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: book.coverColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Spine
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: 6,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.15),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  bottomLeft: Radius.circular(borderRadius),
                ),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 7, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    book.title,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: book.textColor,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                ),
                Text(
                  book.author,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: book.textColor.withOpacity(0.65),
                    fontSize: 7.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The main large cover shown in the hero — matches the red cover in the design image
class MainBookCoverWidget extends StatelessWidget {
  const MainBookCoverWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConstants.coverWidthMain,
      height: AppConstants.coverHeightMain,
      decoration: BoxDecoration(
        color: const Color(0xFFE8574A),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.22),
            blurRadius: 18,
            offset: const Offset(4, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Spine
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: 8,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.15),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
            ),
          ),
          // Cover content
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 18, 10, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 2, color: Colors.white.withOpacity(0.5)),
                const SizedBox(height: 10),
                const Text(
                  'MY\nBOOK\nCOVER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    height: 1.1,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 6),
                Container(height: 1, color: Colors.white.withOpacity(0.3)),
                const SizedBox(height: 6),
                const Text(
                  'A story of data,\npower & choice',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 8,
                    height: 1.4,
                  ),
                ),
                const Spacer(),
                Container(height: 1, color: Colors.white.withOpacity(0.3)),
                const SizedBox(height: 6),
                const Text(
                  'By Jane Baker',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
