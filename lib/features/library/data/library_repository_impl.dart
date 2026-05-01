import 'dart:typed_data';
import 'package:readify_app/features/library/data/library_remote_data_source.dart';
import 'package:readify_app/features/library/domain/entities/user_book_model.dart';
import 'package:readify_app/features/library/domain/library_repository.dart';

class LibraryRepositoryImpl implements LibraryRepository {
  final LibraryRemoteDataSource remote;

  LibraryRepositoryImpl({required this.remote});

  @override
  Future<List<UserBookModel>> getUserBooks() {
    return remote.fetchUserBooks();
  }

  @override
  Future<void> updateReadingProgress({
    required int bookId,
    required double progressPercentage,
  }) {
    return remote.updateReadingProgress(
      bookId: bookId,
      progressPercentage: progressPercentage,
    );
  }

  @override
  Future<Uint8List> downloadBookBytes({required int bookId}) {
    return remote.downloadBookBytes(bookId: bookId);
  }
}
