import 'package:readify_app/features/home/domain/featured_books_model.dart';
import 'package:readify_app/features/home/domain/free_book_model.dart';
import 'package:readify_app/features/home/domain/recent_books_model.dart';
import 'package:readify_app/features/home/domain/top_selling_book_model.dart';

abstract class FeaturedBooksRepository {
  Future<List<FeaturedBookModel>> getFeaturedBooks();

  Future<List<RecentBooksModel>> getRecentBooks();
  Future<List<TopSellingBookModel>> getTopSellingBooks();

  Future<List<FreeBookModel>> getFreeBooks();
}
