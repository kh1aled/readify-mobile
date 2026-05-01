import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
import 'package:readify_app/core/services/token_storage_service.dart';
import 'package:readify_app/features/library/data/download_service.dart';
import 'package:readify_app/features/library/domain/entities/user_book_model.dart';
import 'package:readify_app/features/library/domain/library_repository.dart';
import 'package:readify_app/features/library/presentation/widgets/book_cover.dart';

// Use conditional import to prevent mobile crashes
import 'download_web.dart' if (dart.library.html) 'download_web.dart';

class BookListItem extends StatelessWidget {
  const BookListItem({
    super.key,
    required this.book,
    required this.primaryColor,
    required this.downloadService,
    this.onTap,
  });

  final UserBookModel book;
  final Color primaryColor;
  final DownloadService downloadService;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: downloadService,
      builder: (context, _) {
        final dlState = downloadService.stateFor(book.bookId);
        final progressPercent = book.bookProgressPercentage
            .clamp(0.0, 100.0)
            .toInt();

        return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              children: [
                BookCover(coverUrl: book.bookCover, width: 50, height: 75),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.bookTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 2),

                      Text(
                        book.bookAuthor,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),

                      const SizedBox(height: 6),

                      _ProgressBar(
                        value: book.bookProgressPercentage / 100,
                        color: primaryColor,
                      ),

                      const SizedBox(height: 4),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$progressPercent% complete',
                            style: TextStyle(
                              fontSize: 11,
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          _StatusBadge(status: book.status),
                        ],
                      ),

                      if (dlState.isDownloading) ...[
                        const SizedBox(height: 6),
                        _ProgressBar(
                          value: dlState.progress,
                          color: Colors.blue,
                          height: 3,
                        ),
                        Text(
                          'Downloading...',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(width: 10),

                _DownloadButton(
                  dlState: dlState,
                  isAlreadyDownloaded: book.isDownloaded,
                  onTap: () async {
                    await downloadService.downloadBook(
                      bookId: book.bookId,
                      fileName: 'book_${book.bookId}.pdf',
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final double value;
  final Color color;
  final double height;
  const _ProgressBar({
    required this.value,
    required this.color,
    this.height = 4,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: LinearProgressIndicator(
        value: value,
        backgroundColor: Colors.grey.shade200,
        color: color,
        minHeight: height,
      ),
    );
  }
}

// ── Small widgets ──────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});
  final String status;

  Color get _color {
    switch (status) {
      case 'Reading':
        return Colors.green;
      case 'Completed':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w600,
          color: _color,
        ),
      ),
    );
  }
}

class _DownloadButton extends StatelessWidget {
  const _DownloadButton({
    required this.dlState,
    required this.isAlreadyDownloaded,
    required this.onTap,
  });

  final DownloadState dlState;
  final bool isAlreadyDownloaded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (dlState.isDownloading) {
      return SizedBox(
        width: 22,
        height: 22,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          value: dlState.progress > 0 ? dlState.progress : null,
          color: Colors.blue,
        ),
      );
    }

    if (dlState.isComplete || isAlreadyDownloaded) {
      return Icon(
        Icons.download_done_rounded,
        size: 22,
        color: Colors.green.shade400,
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Icon(
        dlState.error != null ? Icons.refresh_rounded : Icons.download_outlined,
        size: 22,
        color: Colors.grey.shade400,
      ),
    );
  }
}
