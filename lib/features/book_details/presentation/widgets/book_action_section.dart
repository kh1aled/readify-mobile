import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import 'package:readify_app/features/book_details/domain/entities.dart';

class BookActionSection extends StatefulWidget {
  final BookEntity book;

  const BookActionSection({super.key, required this.book});

  @override
  State<BookActionSection> createState() => _BookActionSectionState();
}

class _BookActionSectionState extends State<BookActionSection> {
  bool _isWishlisted = false;
  bool _isInLibrary = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.fromLTRB(
        AppConstants.pagePadding,
        16,
        AppConstants.pagePadding,
        0,
      ),
      child: Column(
        children: [
          // ── Buy Button ────────────────────────────────────────────
          SizedBox(
            width: double.infinity,
            height: AppConstants.buyButtonHeight,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.teal,
                foregroundColor: AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppConstants.buttonRadius),
                ),
              ),
              child: Text(
                'Buy \$${widget.book.price.toStringAsFixed(0)}\$',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          // ── List Price ────────────────────────────────────────────
          if (widget.book.originalPrice != null)
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'list price: ${widget.book.originalPrice}\$',
                style: AppTextStyles.priceStrike,
              ),
            ),
          const SizedBox(height: 12),
          // ── Secondary Actions ─────────────────────────────────────
          Row(
            children: [
              // Wishlist
              _IconActionButton(
                icon: _isWishlisted
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                iconColor:
                    _isWishlisted ? AppColors.red : AppColors.textLight,
                onTap: () =>
                    setState(() => _isWishlisted = !_isWishlisted),
                tooltip: 'Wishlist',
              ),
              const SizedBox(width: 10),
              // Add to Library
              Expanded(
                child: _LabelActionButton(
                  icon: _isInLibrary
                      ? Icons.check_circle_rounded
                      : Icons.add_circle_outline_rounded,
                  label: _isInLibrary ? 'In Library' : 'Add to Library',
                  active: _isInLibrary,
                  onTap: () =>
                      setState(() => _isInLibrary = !_isInLibrary),
                ),
              ),
              const SizedBox(width: 10),
              // Read Now
              Expanded(
                child: _LabelActionButton(
                  icon: Icons.menu_book_rounded,
                  label: 'Read Now',
                  active: true,
                  onTap: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // ── Write Review ──────────────────────────────────────────
          GestureDetector(
            onTap: () => _showWriteReviewSheet(context),
            child: Container(
              width: double.infinity,
              height: 44,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.rate_review_outlined,
                      color: AppColors.textLight, size: 17),
                  SizedBox(width: 8),
                  Text(
                    'Write a Review',
                    style: TextStyle(
                      color: AppColors.textLight,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _showWriteReviewSheet(BuildContext context) {
    int selectedRating = 0;
    final controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => StatefulBuilder(
        builder: (ctx, setModal) => Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Write a Review',
                style: TextStyle(
                  color: AppColors.textDark,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text('Your rating',
                  style: TextStyle(
                      color: AppColors.textMid, fontSize: 13)),
              const SizedBox(height: 8),
              Row(
                children: List.generate(5, (i) {
                  return GestureDetector(
                    onTap: () =>
                        setModal(() => selectedRating = i + 1),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(
                        i < selectedRating
                            ? Icons.star_rounded
                            : Icons.star_outline_rounded,
                        color: AppColors.star,
                        size: 32,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                maxLines: 4,
                style: const TextStyle(
                    color: AppColors.textDark, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Share your thoughts...',
                  hintStyle: const TextStyle(
                      color: AppColors.textLight, fontSize: 14),
                  filled: true,
                  fillColor: AppColors.bg,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: AppColors.teal),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Submit Review',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconActionButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;
  final String tooltip;

  const _IconActionButton({
    required this.icon,
    required this.iconColor,
    required this.onTap,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Tooltip(
        message: tooltip,
        child: Container(
          width: 48,
          height: 44,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
      ),
    );
  }
}

class _LabelActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _LabelActionButton({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        height: 44,
        decoration: BoxDecoration(
          color: active ? AppColors.tealLight : Colors.transparent,
          border: Border.all(
            color: active ? AppColors.tealBorder : AppColors.border,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: active ? AppColors.teal : AppColors.textLight,
              size: 16,
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                color: active ? AppColors.teal : AppColors.textLight,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
