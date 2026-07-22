import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  TokenStorage._();

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String _tokenKey = 'access_token';

  static Future<void> saveToken(String token) async {
    print("Saving Token...");
    print(token);

    await _storage.write(key: _tokenKey, value: token);

    final saved = await _storage.read(key: _tokenKey);

    print("Saved Token:");
    print(saved);
  }

  static Future<String?> getToken() async {
    final token = await _storage.read(key: _tokenKey);

    print("Reading Token:");
    print(token);

    return token;
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }
}