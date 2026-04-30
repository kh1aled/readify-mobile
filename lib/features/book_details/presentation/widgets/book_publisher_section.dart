import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import 'package:readify_app/features/book_details/domain/book_details_model.dart';

class BookPublisherSection extends StatelessWidget {
  final BookDetailsModel book;

  const BookPublisherSection({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(AppConstants.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Publisher Information', style: AppTextStyles.titleMedium),
          const SizedBox(height: 12),
          _InfoRow('Publisher', book.publisherName ?? '-'),
          _InfoRow('Release Date', book.addedDate),
          _InfoRow('Pages', '120'),
          _InfoRow('Language', 'English'),
          _InfoRow('Genre', book.genreName),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(label, style: AppTextStyles.caption),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppColors.textDark,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
