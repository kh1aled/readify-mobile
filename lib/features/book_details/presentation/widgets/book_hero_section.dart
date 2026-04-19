import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import 'package:readify_app/features/book_details/domain/entities.dart';
import 'book_cover_widget.dart';

class BookHeroSection extends StatelessWidget {
  final BookEntity book;

  const BookHeroSection({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28),
      child: const Center(child: MainBookCoverWidget()),
    );
  }
}

class BookInfoSection extends StatelessWidget {
  final BookEntity book;

  const BookInfoSection({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.pagePadding,
        0,
        AppConstants.pagePadding,
        20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            book.title,
            style: AppTextStyles.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            book.author,
            style: AppTextStyles.subtitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            'Released ${book.publishDate}',
            style: AppTextStyles.caption,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class BookStatsRow extends StatelessWidget {
  final BookEntity book;

  const BookStatsRow({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.pagePadding,
        vertical: 14,
      ),
      child: Row(
         mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _StatItem(
            topWidget: Row(
              children: [
                Text(book.rating.toString(), style: AppTextStyles.statValue),
                const SizedBox(width: 4),
                const Icon(Icons.star_rounded, color: AppColors.star, size: 18),
              ],
            ),
            label: '${book.formattedReviewCount} reviews',
          ),
          _VerticalSeparator(),
          _StatItem(
            topWidget: Text('${book.pages}', style: AppTextStyles.statValue),
            label: 'Pages',
          ),
          _VerticalSeparator(),
          const _StatItem(
            topWidget: Icon(
              Icons.tablet_mac_outlined,
              color: AppColors.textDark,
              size: 22,
            ),
            label: 'EBook',
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final Widget topWidget;
  final String label;

  const _StatItem({required this.topWidget, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        topWidget,
        const SizedBox(height: 2),
        Text(label, style: AppTextStyles.statLabel),
      ],
    );
  }
}

class _VerticalSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: 1,
      color: AppColors.border,
      margin: const EdgeInsets.symmetric(horizontal: 20),
    );
  }
}
