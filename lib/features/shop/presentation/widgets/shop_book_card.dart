import 'package:flutter/material.dart';

class ShopBookCard extends StatelessWidget {
  const ShopBookCard({
    super.key,
    required this.title,
    required this.author,
    required this.price,
    required this.coverUrl,
    this.onTap,
  });

  final String title;
  final String author;
  final String price;
  final String coverUrl;
  final VoidCallback? onTap;

  bool get isFree => price.toLowerCase() == 'free';

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 110,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                coverUrl,
                width: 110,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 110,
                  height: 150,
                  color: Colors.grey.shade200,
                  child: Icon(Icons.book_rounded,
                      color: Colors.grey.shade400, size: 36),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Title
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1C1C1E),
                height: 1.3,
              ),
            ),
            const SizedBox(height: 2),
            // Author
            Text(
              author,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
            ),
            const SizedBox(height: 6),
            // Price badge
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: isFree
                    ? Colors.green.shade50
                    : primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                price,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: isFree ? Colors.green.shade700 : primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}