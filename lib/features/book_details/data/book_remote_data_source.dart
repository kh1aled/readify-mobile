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
    final response = await _client.get(
      Uri.parse('$_baseUrl/books/$bookId'),
      headers: _jsonHeaders(),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final body = jsonDecode(response.body);

      final data = body['book'] ?? body;

      return BookDetailsModel.fromJson(data);
    }

    throw BookException('Failed to fetch book details');
  }

  Map<String, String> _jsonHeaders() => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}
