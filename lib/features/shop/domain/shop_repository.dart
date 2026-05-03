import 'package:readify_app/features/shop/domain/genre_model.dart';

abstract class ShopRepository {
  Future<List<GenreModel>> getGenres();
}