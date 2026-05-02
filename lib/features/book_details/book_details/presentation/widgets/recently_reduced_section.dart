import 'package:flutter/material.dart';
import 'package:readify_app/core/constants/app_constants.dart';
import 'package:readify_app/core/theme/app_colors.dart';
import 'package:readify_app/core/theme/app_text_styles.dart';
import 'package:readify_app/features/book_details/book_details/domain/book_details_model.dart';
import 'book_cover_widget.dart';

class RecentlyReducedSection extends StatelessWidget {
  final List<BookDetailsModel> books;
  const RecentlyReducedSection({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(AppConstants.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('💸 Recently Reduced', style: AppTextStyles.titleMedium),
              GestureDetector(
                onTap: () {},
                child: const Text('See all', style: AppTextStyles.seeAll),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...books.map((b) => _ReducedBookRow(book: b)),
        ],
      ),
    );
  }
}

class _ReducedBookRow extends StatelessWidget {
  final BookDetailsModel book;

  const _ReducedBookRow({required this.book});

  @override
  Widget build(BuildContext context) {
    // Determine if there's a discount by checking if originalPrice field exists
    // Since BookDetailsModel doesn't have originalPrice, we show only the current price
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          BookCoverWidget(book: book, width: 60, height: 82, borderRadius: 6),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  style: const TextStyle(
                    color: AppColors.textDark,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(book.authorName, style: AppTextStyles.statLabel),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      '\$${book.price.toStringAsFixed(2)}',
                      style: AppTextStyles.priceSmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 7),
                  decoration: BoxDecoration(
                    color: AppColors.teal,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Buy',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
