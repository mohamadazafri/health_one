import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final _storage = FlutterSecureStorage();

  static Future<void> writeStorage(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  static Future<String> readStorage(String key) async {
    return await _storage.read(key: key) as String;
  }

  static Future<Map<String, String>> readAllStorage() async {
    return await _storage.readAll();
  }

  static Future<void> deleteAllStorage() async {
    return await _storage.deleteAll();
  }
}
