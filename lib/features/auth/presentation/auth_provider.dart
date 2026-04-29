import 'package:flutter/foundation.dart';
import 'package:readify_app/features/auth/data/auth_repository_impl.dart';
import '../domain/user_model.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthProvider extends ChangeNotifier {
  final AuthRepositoryImpl _repository;

  AuthProvider(this._repository);

  AuthStatus _status = AuthStatus.initial;
  UserModel? _user;
  String? _errorMessage;

  AuthStatus get status => _status;
  UserModel? get user => _user;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _status == AuthStatus.authenticated;

  // ── Login ──────────────────────────────────────────────────────────────────

  Future<bool> login({required String email, required String password}) async {
    _setLoading();
    try {
      final result = await _repository.login(email: email, password: password);
      _setAuthenticated(result.user);
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  // ── Register ───────────────────────────────────────────────────────────────

  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    _setLoading();
    try {
      final result = await _repository.register(
        name: name,
        email: email,
        password: password,
      );
      _setAuthenticated(result.user);
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  // ── Logout ─────────────────────────────────────────────────────────────────

  Future<void> logout() async {
    await _repository.logout();
    _user = null;
    _errorMessage = null;
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  void _setLoading() {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();
  }

  void _setAuthenticated(UserModel user) {
    _user = user;
    _status = AuthStatus.authenticated;
    _errorMessage = null;
    notifyListeners();
  }

  void _setError(String message) {
    _status = AuthStatus.error;
    _errorMessage = message;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    if (_status == AuthStatus.error) {
      _status = AuthStatus.unauthenticated;
    }
    notifyListeners();
  }
}