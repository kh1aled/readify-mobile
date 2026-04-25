import 'dart:convert';
import 'package:http/http.dart';
import 'package:readify_app/core/constants/app_constants.dart';
import 'package:readify_app/features/auth/data/models/user_model.dart';

class AuthRemoteDataSource {
  final Client client;

  AuthRemoteDataSource({required this.client});

  Future<UserModel> register(
    String email,
    String password,
    String fullName,
  ) async {
    final response = await client.post(
      Uri.parse('${AppConstants.apiBaseUrl}/register'),
      body: {'email': email, 'password': password, 'fullName': fullName},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data);
    } else {
      throw Exception('Failed to register');
    }
  }
}
