import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import 'package:readify_app/features/book_details/domain/entities.dart';
import 'book_cover_widget.dart';

class BookShelfSection extends StatelessWidget {
  final String title;
  final List<BookEntity> books;

  const BookShelfSection({
    super.key,
    required this.title,
    required this.books,
  });

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
              Text(title, style: AppTextStyles.titleMedium),
              GestureDetector(
                onTap: () {},
                child: const Text('See all', style: AppTextStyles.seeAll),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 158,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: books.length,
              itemBuilder: (_, i) => Padding(
                padding: const EdgeInsets.only(right: 14),
                child: _BookCard(book: books[i]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BookCard extends StatelessWidget {
  final BookEntity book;

  const _BookCard({required this.book});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppConstants.coverWidthSmall,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BookCoverWidget(book: book),
          const SizedBox(height: 7),
          Text(
            book.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textDark,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            book.author,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.statLabel,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.star_rounded,
                  color: AppColors.star, size: 11),
              const SizedBox(width: 2),
              Text(
                book.rating.toString(),
                style: AppTextStyles.statLabel,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
