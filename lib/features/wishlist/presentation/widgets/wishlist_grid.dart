import 'package:flutter/material.dart';
import 'package:readify_app/features/wishlist/domain/models/wishlist_item_model.dart';
import 'package:readify_app/features/wishlist/presentation/widgets/wishlist_book_card.dart';

class WishlistGrid extends StatelessWidget {
  const WishlistGrid({
    super.key,
    required this.items,
    required this.primaryColor,
  });

  final List<WishlistItemModel> items;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const _EmptyState();

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.78,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) => WishlistBookCard(
        item: items[index],
        primaryColor: primaryColor,
        onTap: () {
          // TODO: navigate to book detail
        },
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border_rounded,
              size: 64, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            'Your wishlist is empty',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Books you save will appear here',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }
}