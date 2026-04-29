import 'package:shared_preferences/shared_preferences.dart';

class TokenStorageService {
  static const _tokenKey = 'auth_token';
  static const _userIdKey = 'user_id';
  static const _userNameKey = 'user_name';
  static const _userEmailKey = 'user_email';
  static const _userImageKey = 'user_image';

  final SharedPreferences _prefs;

  TokenStorageService(this._prefs);

  Future<void> save({
    required String token,
    required String userId,
    String? userName,
    String? userEmail,
    String? userImage,
  }) async {
    await _prefs.setString(_tokenKey, token);
    await _prefs.setString(_userIdKey, userId);
    if (userName != null) await _prefs.setString(_userNameKey, userName);
    if (userEmail != null) await _prefs.setString(_userEmailKey, userEmail);
    if (userImage != null) await _prefs.setString(_userImageKey, userImage);
  }

  /// Update profile image after upload.
  Future<void> saveImage(String imageUrl) async {
    await _prefs.setString(_userImageKey, imageUrl);
  }

  /// Retrieve the stored token, or null if not logged in.
  String? getToken() => _prefs.getString(_tokenKey);

  /// Retrieve the stored user id, or null if not logged in.
  String? getUserId() => _prefs.getString(_userIdKey);

  /// Retrieve cached user data.
  String? getUserName() => _prefs.getString(_userNameKey);
  String? getUserEmail() => _prefs.getString(_userEmailKey);
  String? getUserImage() => _prefs.getString(_userImageKey);

  /// Whether a valid token exists.
  bool get isLoggedIn => getToken() != null;

  /// Clear everything on logout.
  Future<void> clear() async {
    await _prefs.remove(_tokenKey);
    await _prefs.remove(_userIdKey);
    await _prefs.remove(_userNameKey);
    await _prefs.remove(_userEmailKey);
    await _prefs.remove(_userImageKey);
  }
}