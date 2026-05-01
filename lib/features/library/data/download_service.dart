import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:readify_app/features/library/domain/library_repository.dart';

class DownloadService extends ChangeNotifier {
  final LibraryRepository repository;

  DownloadService({required this.repository});

  final Map<int, DownloadState> _states = {};

  DownloadState stateFor(int bookId) {
    return _states[bookId] ?? const DownloadState();
  }

  Future<void> downloadBook({
    required int bookId,
    required String fileName,
  }) async {
    final bytes = await repository.downloadBookBytes(bookId: bookId);

    if (kIsWeb) {
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);

      html.AnchorElement(href: url)
        ..download = fileName
        ..click();

      html.Url.revokeObjectUrl(url);
    } else {
      // mobile logic
    }
  }
}

class DownloadState {
  final bool isDownloading;
  final double progress;
  final bool isComplete;
  final String? error;

  const DownloadState({
    this.isDownloading = false,
    this.progress = 0.0,
    this.isComplete = false,
    this.error,
  });
}
