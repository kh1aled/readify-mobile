import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:readify_app/core/constants/app_constants.dart';
import 'package:readify_app/core/services/token_storage_service.dart';
import 'package:readify_app/features/library/domain/entities/user_book_model.dart';

class LibraryException implements Exception {
  final String message;
  const LibraryException(this.message);
}

class LibraryRemoteDataSource {
  final http.Client _client;
  final TokenStorageService _tokenStorage;

  LibraryRemoteDataSource({
    required TokenStorageService tokenStorage,
    http.Client? client,
  })  : _tokenStorage = tokenStorage,
        _client = client ?? http.Client();

  Map<String, String> _headers([String? token]) => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

  Future<List<UserBookModel>> fetchUserBooks() async {
    final token = _tokenStorage.getToken();

    final response = await _client.get(
      Uri.parse('${AppConstants.apiBaseUrl}/books/user'),
      headers: _headers(token),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw LibraryException('Failed to fetch books');
    }

    final body = jsonDecode(response.body);

    final list = body is List
        ? body
        : (body['userBooks'] ?? body['data'] ?? []);

    return (list as List)
        .map((e) => UserBookModel.fromJson(e))
        .toList();
  }

  /// 🔥 FIX: return bytes ONLY (no html here)
  Future<Uint8List> downloadBookBytes({
    required int bookId,
  }) async {
    final token = _tokenStorage.getToken();

    final response = await _client.get(
      Uri.parse('${AppConstants.apiBaseUrl}/books/download/$bookId'),
      headers: _headers(token),
    );

    if (response.statusCode != 200) {
      throw LibraryException('Download failed');
    }

    return response.bodyBytes;
  }

  Future<void> updateReadingProgress({
    required int bookId,
    required double progressPercentage,
  }) async {
    final token = _tokenStorage.getToken();

    final response = await _client.patch(
      Uri.parse('${AppConstants.apiBaseUrl}/user/books/$bookId/progress'),
      headers: _headers(token),
      body: jsonEncode({
        'progressPercentage': progressPercentage,
      }),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw LibraryException('Failed to update progress');
    }
  }
}