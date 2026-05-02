import 'package:readify_app/core/services/token_storage_service.dart';
import 'package:readify_app/features/wishlist/data/services/wishlist_service.dart';
import 'package:readify_app/features/wishlist/domain/models/wishlist_item_model.dart';

class WishlistRepository {
  WishlistRepository({
    required TokenStorageService tokenStorage,
    WishlistService? wishlistService,
  })  : _tokenStorage = tokenStorage,
        _service = wishlistService ?? WishlistService();

  final TokenStorageService _tokenStorage;
  final WishlistService _service;

  Future<List<WishlistItemModel>> getWishlist() async {
    final token = _tokenStorage.getToken();

    if (token == null) {
      throw WishlistException('No auth token found – please log in.');
    }

    return _service.fetchWishlist(token);
  }
}
