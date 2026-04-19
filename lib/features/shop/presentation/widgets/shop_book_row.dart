import 'package:flutter/material.dart';
import 'package:readify_app/features/shop/presentation/widgets/shop_book_card.dart';

class ShopBookRow extends StatelessWidget {
  const ShopBookRow({super.key, required this.books});
  final List<Map<String, dynamic>> books;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final book = books[index];
          return ShopBookCard(
            title: book['title'] as String,
            author: book['author'] as String,
            price: book['price'] as String,
            coverUrl: book['coverUrl'] as String,
            onTap: () {
              // TODO: navigate to book detail
            },
          );
        },
      ),
    );
  }
}