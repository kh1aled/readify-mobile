import 'package:flutter/material.dart';
import 'package:readify_app/core/constants/app_constants.dart';
import 'package:readify_app/core/theme/app_colors.dart';
import 'package:readify_app/core/theme/app_text_styles.dart';
import 'package:readify_app/features/book_details/book_details/domain/book_details_model.dart';
import 'package:readify_app/features/book_details/book_details/domain/review_model.dart';

Map<int, int> getRatingCounts(List<ReviewModel> reviews) {
  Map<int, int> counts = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};

  for (var review in reviews) {
    counts[review.rating] = counts[review.rating]! + 1;
  }

  return counts;
}

double getFraction(int star, Map<int, int> counts, int total) {
  if (total == 0) return 0;
  return counts[star]! / total;
}

class BookReviewsSection extends StatelessWidget {
  final BookDetailsModel book;
  final List<ReviewModel> reviews;
  final VoidCallback onWriteReview;


  const BookReviewsSection({
    super.key,
    required this.book,
    required this.reviews,
    required this.onWriteReview,
  });

  @override
  Widget build(BuildContext context) {
    bool submitting = false;

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
                child: const Text('See all', style: AppTextStyles.seeAll),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _RatingOverviewWidget(book: book),
          const SizedBox(height: 20),
          ...reviews.map((r) => _ReviewCard(review: r)).toList(),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: onWriteReview,
            icon: const Icon(
              Icons.rate_review_outlined,
              size: 15,
              color: AppColors.teal,
            ),
            label: const Text(
              'Write a Review',
              style: TextStyle(color: AppColors.teal, fontSize: 13),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.teal),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingOverviewWidget extends StatelessWidget {
  final BookDetailsModel book;
  const _RatingOverviewWidget({required this.book});

  @override
  Widget build(BuildContext context) {
    final counts = getRatingCounts(book.reviews);
    final total = book.reviews.length;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book.rating.toStringAsFixed(1),
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
            Text('$total ratings', style: AppTextStyles.statLabel),
          ],
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            children: [5, 4, 3, 2, 1].map((s) {
              final fraction = getFraction(s, counts, total);
              final count = counts[s]!; // add this

              return _RatingBar(
                stars: s,
                fraction: fraction,
                count: count,
              ); // pass count
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _RatingBar extends StatelessWidget {
  final int stars;
  final double fraction;
  final int count; // add this

  const _RatingBar({
    required this.stars,
    required this.fraction,
    required this.count, // add this
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 16,
            child: Text('$stars', style: AppTextStyles.statLabel),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: fraction,
                backgroundColor: AppColors.border,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.star),
                minHeight: 7,
              ),
            ),
          ),
          const SizedBox(width: 6),
          SizedBox(
            width: 20,
            child: Text(
              '$count',
              style: AppTextStyles.statLabel,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final ReviewModel review;
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
                backgroundColor: const Color.fromARGB(255, 193, 48, 48),
                backgroundImage: NetworkImage(review.userImage),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(review.userName, style: AppTextStyles.reviewName),
                  Row(
                    children: List.generate(
                      review.rating,
                      (_) => const Icon(
                        Icons.star_rounded,
                        color: AppColors.star,
                        size: 11,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(review.createdAt, style: AppTextStyles.statLabel),
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
