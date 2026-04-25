import 'package:readify_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<String> signIn(String email, String password) {
    // Implement sign-in logic here, e.g., make an API call to authenticate the user
    // and return the authentication token.
    throw UnimplementedError();
  }

  @override
    Future<void> signOut() {
    // Implement sign-out logic here, e.g., clear the authentication token from storage.
    throw UnimplementedError();
  }
  
  @override
  Future<void> signUp(String email, String password, String fullName) {
    // Implement sign-up logic here, e.g., make an API call to register the user.
    throw UnimplementedError();
  }
}
