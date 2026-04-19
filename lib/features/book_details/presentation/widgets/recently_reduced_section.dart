import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import 'package:readify_app/features/book_details/domain/entities.dart';
import 'book_cover_widget.dart';

class RecentlyReducedSection extends StatelessWidget {
  final List<BookEntity> books;

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
              Text('💸 Recently Reduced',
                  style: AppTextStyles.titleMedium),
              GestureDetector(
                onTap: () {},
                child:
                    const Text('See all', style: AppTextStyles.seeAll),
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
  final BookEntity book;

  const _ReducedBookRow({required this.book});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          BookCoverWidget(
            book: book,
            width: 60,
            height: 82,
            borderRadius: 6,
          ),
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
                Text(book.author,
                    style: AppTextStyles.statLabel),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text('\$${book.price}',
                        style: AppTextStyles.priceSmall),
                    const SizedBox(width: 6),
                    if (book.hasDiscount)
                      Text('\$${book.originalPrice}',
                          style: AppTextStyles.priceStrike),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (book.hasDiscount)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.greenLight.withOpacity(0.4),
                    ),
                  ),
                  child: Text(
                    '-${book.discountPercent}%',
                    style: const TextStyle(
                      color: AppColors.greenLight,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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
