import 'package:flutter_app_template/core/data/storage/storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final class SecureStorage implements IKeyValueStorage {
  SecureStorage({required FlutterSecureStorage flutterSecureStorage})
    : _flutterSecureStorage = flutterSecureStorage;

  final FlutterSecureStorage _flutterSecureStorage;

  @override
  Future<bool> write<T>({required String key, required T value}) async {
    if (value is String) {
      await _flutterSecureStorage.write(key: key, value: value);
      return true;
    } else {
      throw ArgumentError('SecureStorage supports only String values');
    }
  }

  @override
  Future<T?> read<T>({required String key}) async {
    try {
      final value = await _flutterSecureStorage.read(key: key);
      if (value == null) return null;

      if (T == String) return value as T;
      throw ArgumentError('SecureStorage only supports reading String values');
    } catch (e, _) {
      return null;
    }
  }

  @override
  Future<bool> delete({required String key}) async {
    await _flutterSecureStorage.delete(key: key);
    return true;
  }

  @override
  Future<bool> clear() async {
    await _flutterSecureStorage.deleteAll();
    return true;
  }
}
