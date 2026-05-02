

import 'package:readify_app/features/book_details/book_details/data/book_remote_data_source.dart';
import 'package:readify_app/features/book_details/book_details/domain/book_details_model.dart';
import 'package:readify_app/features/book_details/book_details/domain/book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  BookRepositoryImpl._();
  static final BookRepositoryImpl instance = BookRepositoryImpl._();

  final BookRemoteDataSource _dataSource = BookRemoteDataSource();

  @override
  Future<BookDetailsModel> fetchBookDetails(int bookId) async {
    return _dataSource.fetchBookDetails(bookId);
  }

  @override
  Future<void> addReview(
    int bookId,
    String userId,
    String comment,
    int rating,
  ) async {
    return _dataSource.addReview(bookId, userId, comment, rating);
  }

  @override
  Future<void> purchaseBook(int bookId, String token) async {
    return _dataSource.purchaseBook(bookId, token);
  }
}
