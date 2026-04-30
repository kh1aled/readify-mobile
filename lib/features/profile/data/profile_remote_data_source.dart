import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:readify_app/core/constants/app_constants.dart';
import 'package:readify_app/core/services/token_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/profile_model.dart';
import 'dart:io';

class ProfileException implements Exception {
  final String message;
  const ProfileException(this.message);

  @override
  String toString() => message;
}

class ProfileRemoteDataSource {
  static const _baseUrl = AppConstants.apiBaseUrl;
  final TokenStorageService _tokenStorage;
  final http.Client _client;

  ProfileRemoteDataSource({
    http.Client? client,
    required TokenStorageService tokenStorage,
  })  : _tokenStorage = tokenStorage,
        _client = client ?? http.Client();

  Future<ProfileModel> getProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      final response = await _client.get(
        Uri.parse('$_baseUrl/auth/profile'),
        headers: _jsonHeaders(token: token),
      );

      return _parseProfileResponse(response);
    } on ProfileException {
      rethrow;
    } catch (e) {
      throw ProfileException('Network error: $e');
    }
  }

  Future<String> uploadProfileImageBytes(
    Uint8List bytes,
    String fileName,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$_baseUrl/auth/upload-profile-image'),
      );

      request.headers['Authorization'] = 'Bearer $token';
      request.files.add(
        http.MultipartFile.fromBytes('image', bytes, filename: fileName),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      return _parseImageUrl(response);
    } on ProfileException {
      rethrow;
    } catch (e) {
      throw ProfileException('Network error: $e');
    }
  }

  Future<String> uploadProfileImage(File image) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$_baseUrl/auth/upload-profile-image'),
      );

      request.headers['Authorization'] = 'Bearer $token';
      request.files.add(
        await http.MultipartFile.fromPath('image', image.path),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      return _parseImageUrl(response);
    } on ProfileException {
      rethrow;
    } catch (e) {
      throw ProfileException('Network error: $e');
    }
  }

  Future<void> logout() async {
    await _tokenStorage.clear();
  }

  // ── Private helpers ────────────────────────────────────────────────────────

  String _parseImageUrl(http.Response response) {
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final url = body['imageUrl'] as String?;
      if (url == null || url.isEmpty) {
        throw const ProfileException('Server returned empty image URL');
      }
      return url;
    }
    throw ProfileException('Upload failed (status ${response.statusCode})');
  }

  Map<String, String> _jsonHeaders({String? token}) => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

  ProfileModel _parseProfileResponse(http.Response response) {
    if (response.body.isEmpty) {
      throw const ProfileException('Empty response from server');
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return ProfileModel.fromJson(body);
    }

    final message =
        body['message'] ?? body['error'] ?? 'Failed to load profile';
    throw ProfileException(message as String);
  }
}
