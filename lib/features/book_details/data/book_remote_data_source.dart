import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:readify_app/core/constants/app_constants.dart';
import 'package:readify_app/features/book_details/domain/book_details_model.dart';

class BookException implements Exception {
  final String message;
  const BookException(this.message);

  @override
  String toString() => message;
}

class BookRemoteDataSource {
  static const _baseUrl = AppConstants.apiBaseUrl;
  final http.Client _client;

  BookRemoteDataSource({http.Client? client})
    : _client = client ?? http.Client();

  Future<BookDetailsModel> fetchBookDetails(int bookId) async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/books/$bookId'),
        headers: _jsonHeaders(),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        final data = body['book'] ?? body;
        return BookDetailsModel.fromJson(data as Map<String, dynamic>);
      }

      throw BookException(
        'Failed to fetch book details (status ${response.statusCode})',
      );
    } on BookException {
      rethrow;
    } catch (e) {
      throw BookException('Network error: $e');
    }
  }

  Future<void> addReview(
    int bookId,
    String userId,
    String comment,
    int rating,
  ) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/books/create-review'),
        headers: _jsonHeaders(),
        body: jsonEncode({
          'bookId': bookId,
          'userId': userId,
          'comment': comment,
          'rating': rating,
        }),
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw BookException(
          'Failed to add review (status ${response.statusCode})',
        );
      }
    } on BookException {
      rethrow;
    } catch (e) {
      throw BookException('Network error: $e');
    }
  }

  Future<void> purchaseBook(int bookId, String token) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/books/purchase'),
        headers: _jsonHeadersWithTokens(token: token),
        body: jsonEncode({'bookId': bookId}),
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw BookException(
          'Failed to purchase book (status ${response.statusCode})',
        );
      }
    } on BookException {
      rethrow;
    } catch (e) {
      throw BookException('Network error: $e');
    }
  }

  Map<String, String> _jsonHeaders() => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<bool> isBookPurchased(int bookId, String token) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/books/is-purchased/$bookId'),
      headers: _jsonHeadersWithTokens(token: token),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body);
      return data['isPurchased'] ?? false;
    }

    throw BookException('Failed to check purchase');
  }

  Map<String, String> _jsonHeadersWithTokens({String? token}) => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    if (token != null) 'Authorization': 'Bearer $token',
  };
}
