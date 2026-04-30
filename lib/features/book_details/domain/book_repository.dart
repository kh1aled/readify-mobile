import 'package:readify_app/features/book_details/domain/book_details_model.dart';

abstract class BookRepository {
  Future<BookDetailsModel> fetchBookDetails(int bookId);
}