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
  }) : _tokenStorage = tokenStorage,
       _client = client ?? http.Client();

  Future<ProfileModel> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("auth_token");

    final response = await _client.get(
      Uri.parse('$_baseUrl/auth/profile'),
      headers: _jsonHeaders(token: token),
    );

    return _parseProfileResponse(response);
  }

  Future<String> uploadProfileImageBytes(
    Uint8List bytes,
    String fileName,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("auth_token");

    var request = http.MultipartRequest(
      "POST",
      Uri.parse("$_baseUrl/auth/upload-profile-image"),
    );

    request.headers["Authorization"] = "Bearer $token";
    request.files.add(
      http.MultipartFile.fromBytes("image", bytes, filename: fileName),
    );

    var streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body['imageUrl'] as String;
    } else {
      throw ProfileException("Upload failed: ${response.statusCode}");
    }
  }

  Future<String> uploadProfileImage(File image) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("auth_token");
    var request = http.MultipartRequest(
      "POST",
      Uri.parse("$_baseUrl/auth/upload-profile-image"),
    );

    request.headers["Authorization"] = "Bearer $token";
    request.files.add(await http.MultipartFile.fromPath("image", image.path));

    var streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body['imageUrl'] as String;
    } else {
      throw ProfileException("Upload failed: ${response.statusCode}");
    }
  }

  Future<void> logout() async {
    await _tokenStorage.clear();
  }

  Map<String, String> _jsonHeaders({String? token}) => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    if (token != null) 'Authorization': 'Bearer $token',
  };

  ProfileModel _parseProfileResponse(http.Response response) {
    if (response.body.isEmpty) {
      throw ProfileException("Empty response from server");
    }

    final body = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return ProfileModel.fromJson(body);
    }

    final message =
        body['message'] ?? body['error'] ?? 'Failed to load profile';

    throw ProfileException(message);
  }
}
