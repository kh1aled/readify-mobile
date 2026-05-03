import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:readify_app/core/constants/app_constants.dart';
import 'package:readify_app/core/services/token_storage_service.dart';
import 'package:readify_app/features/shop/domain/genre_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopException implements Exception {
  final String message;
  const ShopException(this.message);

  @override
  String toString() => message;
}

class ShopRemoteDataSource {
  static const _baseUrl = AppConstants.apiBaseUrl;
  final TokenStorageService _tokenStorage;
  final http.Client _client;

  ShopRemoteDataSource({
    http.Client? client,
    required TokenStorageService tokenStorage,
  }) : _tokenStorage = tokenStorage,
       _client = client ?? http.Client();

  Future<List<GenreModel>> getGenres() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      final response = await _client.get(
        Uri.parse('$_baseUrl/genres'),
        headers: _jsonHeaders(token: token),
      );

      return _parseGenresResponse(response);
    } on ShopException {
      rethrow;
    } catch (e) {
      throw ShopException('Network error: $e');
    }
  }

  Map<String, String> _jsonHeaders({String? token}) => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    if (token != null) 'Authorization': 'Bearer $token',
  };

  List<GenreModel> _parseGenresResponse(http.Response response) {
    if (response.body.isEmpty) {
      throw const ShopException('Empty response from server');
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return (body['genres'] as List<dynamic>)
          .map((json) => GenreModel.fromJson(json as Map<String, dynamic>))
          .toList();
    }

    final message =
        body['message'] ?? body['error'] ?? 'Failed to load genre';
    throw ShopException(message as String);
  }
}
