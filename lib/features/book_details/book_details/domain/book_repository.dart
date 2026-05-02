
import 'package:readify_app/features/book_details/book_details/domain/book_details_model.dart';

abstract class BookRepository {
  Future<BookDetailsModel> fetchBookDetails(int bookId);

  Future<void> addReview(int bookId, String userId, String comment, int rating);

  Future<void> purchaseBook(int bookId, String token);
}
