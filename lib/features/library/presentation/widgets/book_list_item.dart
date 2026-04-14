import 'package:flutter/material.dart';
import 'package:readify_app/features/library/presentation/widgets/book_cover.dart';

class BookListItem extends StatelessWidget {
  const BookListItem({
    super.key,
    required this.title,
    required this.author,
    required this.progressPercent,
    required this.coverUrl,
    required this.primaryColor,
    this.onDownloadTap,
  });

  final String title;
  final String author;
  final int progressPercent;
  final String coverUrl;
  final Color primaryColor;
  final VoidCallback? onDownloadTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          BookCover(
            coverUrl: coverUrl,
            width: 50,
            height: 75,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1C1C1E),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  author,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
                const SizedBox(height: 6),
                Text(
                  '$progressPercent% complete',
                  style: TextStyle(
                    fontSize: 11,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onDownloadTap,
            child: Icon(
              Icons.download_outlined,
              size: 22,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}