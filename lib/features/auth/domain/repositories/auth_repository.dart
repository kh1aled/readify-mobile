abstract class AuthRepository {
  Future<String> signIn(String email, String password);

  Future<void> signOut();

  Future<void> signUp(String email, String password , String fullName);
}