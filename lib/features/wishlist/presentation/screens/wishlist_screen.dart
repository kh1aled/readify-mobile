import 'package:flutter/material.dart';
import 'package:readify_app/features/wishlist/domain/models/wishlist_item_model.dart';
import 'package:readify_app/features/wishlist/presentation/widgets/wishlist_grid.dart';
import 'package:readify_app/shared/widgets/search_bar.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key ,});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  // Mock data — replace with your state management layer
  final List<WishlistItemModel> _items = List.generate(
    6,
    (i) => WishlistItemModel(
      title: 'Essentialism',
      author: 'Greg McKeown',
      price: 14.99,
      coverUrl: 'https://covers.openlibrary.org/b/id/8739161-M.jpg',
    ),
  );

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F8),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SearchBarWidget(),
                  const SizedBox(height: 16),
                  Text(
                    'Wishlist',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${_items.length} books saved',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: WishlistGrid(items: _items, primaryColor: primary),
            ),
          ],
        ),
      ),
    );
  }
}