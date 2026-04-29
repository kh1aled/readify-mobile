import '../domain/user_model.dart';

abstract class AuthRepository {
  Future<({UserModel user, String token})> login({
    required String email,
    required String password,
  });

  Future<({UserModel user, String token})> register({
    required String name,
    required String email,
    required String password,
  });

  Future<void> logout();
}