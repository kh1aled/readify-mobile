import 'package:readify_app/features/home/data/home_remote_data_source.dart';
import 'package:readify_app/features/home/domain/featured_books_model.dart';
import 'package:readify_app/features/home/domain/featured_books_repository.dart';
import 'package:readify_app/features/home/domain/free_book_model.dart';
import 'package:readify_app/features/home/domain/recent_books_model.dart';
import 'package:readify_app/features/home/domain/top_selling_book_model.dart';

class HomeRepositoryImpl implements FeaturedBooksRepository {
  final HomeRemoteDataSource _remoteDataSource;

  HomeRepositoryImpl({required HomeRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  @override
  Future<List<FeaturedBookModel>> getFeaturedBooks() {
    return _remoteDataSource.fetchFeaturedBooks();
  }

  @override
  Future<List<RecentBooksModel>> getRecentBooks() {
    return _remoteDataSource.fetchRecentBooks();
  }

  @override
  Future<List<TopSellingBookModel>> getTopSellingBooks() {
    return _remoteDataSource.fetchTopSellingBooks();
  }

   @override
  Future<List<FreeBookModel>> getFreeBooks() {
    return _remoteDataSource.fetchFreeBooks();
  }
}
