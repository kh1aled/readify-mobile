import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:readify_app/core/constants/app_constants.dart';
import 'package:readify_app/features/wishlist/domain/models/wishlist_item_model.dart';

class WishlistService {
  WishlistService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  /// Throws a [WishlistException] on network or server errors.
  Future<List<WishlistItemModel>> fetchWishlist(String token) async {
    final uri = Uri.parse('${AppConstants.apiBaseUrl}/books/wishlist');

    final http.Response response;

    try {
      response = await _client.get(
        uri,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );
    } catch (e) {
      throw WishlistException('Network error: $e');
    }

    if (response.statusCode == 200) {
      final Map<String, dynamic> body =
          jsonDecode(response.body) as Map<String, dynamic>;

      final List<dynamic> list = body['wishlist'] as List<dynamic>;

      return list
          .map((e) => WishlistItemModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else if (response.statusCode == 401) {
      throw WishlistException('Unauthorized – please log in again.');
    } else {
      throw WishlistException(
          'Failed to load wishlist (${response.statusCode})');
    }
  }
}

class WishlistException implements Exception {
  WishlistException(this.message);

  final String message;

  @override
  String toString() => 'WishlistException: $message';
}
