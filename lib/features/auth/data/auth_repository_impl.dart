import '../../../core/services/token_storage_service.dart';
import '../domain/auth_repository.dart';
import '../domain/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final TokenStorageService _tokenStorage;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required TokenStorageService tokenStorage,
  })  : _remoteDataSource = remoteDataSource,
        _tokenStorage = tokenStorage;

  @override
  Future<({UserModel user, String token})> login({
    required String email,
    required String password,
  }) async {
    final result = await _remoteDataSource.login(
      email: email,
      password: password,
    );

    await _tokenStorage.save(
      token: result.token,
      userId: result.user.id,
      userName: result.user.name,
      userEmail: result.user.email,
      userImage: result.user.imageUrl,
    );

    return result;
  }

  @override
  Future<({UserModel user, String token})> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final result = await _remoteDataSource.register(
      name: name,
      email: email,
      password: password,
    );

    await _tokenStorage.save(
      token: result.token,
      userId: result.user.id,
      userName: result.user.name,
      userEmail: result.user.email,
      userImage: result.user.imageUrl,
    );

    return result;
  }

  @override
  Future<void> logout() async {
    final token = _tokenStorage.getToken();
    if (token != null) {
      try {
        await _remoteDataSource.logout(token);
      } catch (_) {}
    }
    await _tokenStorage.clear();
  }
}