import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:readify_app/core/constants/app_constants.dart';
import '../domain/user_model.dart';

/// Thrown when the server returns a non-2xx response.
class AuthException implements Exception {
  final String message;
  const AuthException(this.message);

  @override
  String toString() => message;
}

class AuthRemoteDataSource {
  static const _baseUrl = AppConstants.apiBaseUrl;

  final http.Client _client;

  AuthRemoteDataSource({http.Client? client})
    : _client = client ?? http.Client();

  Future<({UserModel user, String token})> login({
    required String email,
    required String password,
  }) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/auth/login'),
      headers: _jsonHeaders(),
      body: jsonEncode({'email': email, 'password': password}),
    );

    return _parseAuthResponse(response);
  }

  Future<({UserModel user, String token})> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/auth/register'),
      headers: _jsonHeaders(),
      body: jsonEncode({
        'fullName': name,
        'email': email,
        'password': password,
      }),
    );

    return _parseAuthResponse(response);
  }

  Future<void> logout(String token) async {
    await _client.post(
      Uri.parse('$_baseUrl/auth/logout'),
      headers: _jsonHeaders(token: token),
    );
  }


  Map<String, String> _jsonHeaders({String? token}) => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    if (token != null) 'Authorization': 'Bearer $token',
  };

  ({UserModel user, String token}) _parseAuthResponse(http.Response response) {
    final body = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // Adjust these keys to match your actual API response shape:
      // { "token": "...", "user": { "id": 1, "fullName": "...", "email": "..." } }
      final token = body['token'] as String;
      final user = UserModel.fromJson(body['user'] as Map<String, dynamic>);
      return (user: user, token: token);
    }

    final message =
        body['message'] as String? ??
        body['error'] as String? ??
        'Authentication failed';

    throw AuthException(message);
  }
}
