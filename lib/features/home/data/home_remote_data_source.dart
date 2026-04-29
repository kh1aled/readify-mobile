import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:readify_app/core/constants/app_constants.dart';
import 'package:readify_app/features/home/domain/featured_books_model.dart';
import 'package:readify_app/features/home/domain/free_book_model.dart';
import 'package:readify_app/features/home/domain/recent_books_model.dart';
import 'package:readify_app/features/home/domain/top_selling_book_model.dart';

class HomeException implements Exception {
  final String message;
  const HomeException(this.message);

  @override
  String toString() => message;
}

class HomeRemoteDataSource {
  static const _baseUrl = AppConstants.apiBaseUrl;
  final http.Client _client;

  HomeRemoteDataSource({http.Client? client})
    : _client = client ?? http.Client();

  Future<List<FeaturedBookModel>> fetchFeaturedBooks() async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/books/featured'),
      headers: _jsonHeaders(),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final body = jsonDecode(response.body);
      // Handle both cases
      final List<dynamic> list = body is List
          ? body
          : (body['books'] ?? body['data'] ?? body['items'] ?? [body]);

      return list
          .map((e) => FeaturedBookModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    throw HomeException('Failed to fetch featured books');
  }

  Future<List<RecentBooksModel>> fetchRecentBooks() async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/books/recent'),
      headers: _jsonHeaders(),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final body = jsonDecode(response.body);

      final List<dynamic> list = body is List
          ? body
          : (body['books'] ?? body['data'] ?? body['items'] ?? [body]);

      return list
          .map((e) => RecentBooksModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    throw HomeException('Failed to fetch recent books');
  }

  Future<List<TopSellingBookModel>> fetchTopSellingBooks() async {
    
      final response = await _client.get(
        Uri.parse('$_baseUrl/books/top-selling'),
        headers: _jsonHeaders(),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final body = jsonDecode(response.body);

        final List<dynamic> list = body is List
            ? body
            : (body['books'] ?? body['data'] ?? body['items'] ?? [body]);

        return list
            .map((e) => TopSellingBookModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }

      throw HomeException('Failed to fetch top-selling books');
    }

  Future<List<FreeBookModel>> fetchFreeBooks() async {
    
      final response = await _client.get(
        Uri.parse('$_baseUrl/books/free'),
        headers: _jsonHeaders(),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final body = jsonDecode(response.body);

        final List<dynamic> list = body is List
            ? body
            : (body['books'] ?? body['data'] ?? body['items'] ?? [body]);

        return list
            .map((e) => FreeBookModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }

      throw HomeException('Failed to fetch free books');
    }

    Map<String, String> _jsonHeaders() => {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
}
