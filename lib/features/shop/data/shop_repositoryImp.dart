import 'package:readify_app/core/services/token_storage_service.dart';
import 'package:readify_app/features/shop/data/shop_remote_data_source.dart';
import 'package:readify_app/features/shop/domain/genre_model.dart';
import 'package:readify_app/features/shop/domain/shop_repository.dart';
class ShopRepositoryImpl implements ShopRepository {
  final ShopRemoteDataSource _dataSource;

  ShopRepositoryImpl({required TokenStorageService tokenStorage})
      : _dataSource = ShopRemoteDataSource(tokenStorage: tokenStorage);

  @override
  Future<List<GenreModel>> getGenres() async {
    return await _dataSource.getGenres();
  }
}