import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import 'package:readify_app/features/book_details/domain/entities.dart';

class BookReviewsSection extends StatelessWidget {
  final BookEntity book;
  final List<ReviewEntity> reviews;

  const BookReviewsSection({
    super.key,
    required this.book,
    required this.reviews,
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
              Text('Reviews', style: AppTextStyles.titleMedium),
              GestureDetector(
                onTap: () {},
                child:
                    const Text('See all', style: AppTextStyles.seeAll),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _RatingOverviewWidget(book: book),
          const SizedBox(height: 20),
          ...reviews.map((r) => _ReviewCard(review: r)),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.rate_review_outlined,
                size: 15, color: AppColors.teal),
            label: const Text('Write a Review',
                style: TextStyle(color: AppColors.teal, fontSize: 13)),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.teal),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 10),
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingOverviewWidget extends StatelessWidget {
  final BookEntity book;
  const _RatingOverviewWidget({required this.book});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book.rating.toString(),
              style: const TextStyle(
                color: AppColors.textDark,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: List.generate(
                5,
                (i) => Icon(
                  i < book.rating.floor()
                      ? Icons.star_rounded
                      : (i < book.rating
                          ? Icons.star_half_rounded
                          : Icons.star_outline_rounded),
                  color: AppColors.star,
                  size: 15,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text('${book.formattedReviewCount} ratings',
                style: AppTextStyles.statLabel),
          ],
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            children: [5, 4, 3, 2, 1]
                .map((s) => _RatingBar(
                      stars: s,
                      fraction: s == 5
                          ? 0.70
                          : s == 4
                              ? 0.18
                              : s == 3
                                  ? 0.08
                                  : s == 2
                                      ? 0.03
                                      : 0.01,
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _RatingBar extends StatelessWidget {
  final int stars;
  final double fraction;
  const _RatingBar({required this.stars, required this.fraction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 16,
            child: Text('$stars',
                style: AppTextStyles.statLabel),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: fraction,
                backgroundColor: AppColors.border,
                valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.star),
                minHeight: 7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final ReviewEntity review;
  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: review.avatarColor.withOpacity(0.15),
                child: Text(
                  review.initials,
                  style: TextStyle(
                    color: review.avatarColor,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(review.name, style: AppTextStyles.reviewName),
                  Row(
                    children: List.generate(
                      review.stars,
                      (_) => const Icon(Icons.star_rounded,
                          color: AppColors.star, size: 11),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(review.date, style: AppTextStyles.statLabel),
            ],
          ),
          const SizedBox(height: 8),
          Text(review.comment, style: AppTextStyles.reviewBody),
          const Divider(height: 20, color: AppColors.border),
        ],
      ),
    );
  }
}
