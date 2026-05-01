import 'dart:typed_data';
import 'package:readify_app/features/library/domain/entities/user_book_model.dart';

abstract class LibraryRepository {
  Future<List<UserBookModel>> getUserBooks();

  Future<void> updateReadingProgress({
    required int bookId,
    required double progressPercentage,
  });

  Future<Uint8List> downloadBookBytes({
    required int bookId,
  });
}