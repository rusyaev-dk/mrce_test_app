abstract interface class IKeyValueStorage {
  Future<bool> save<T>({required String key, required T value});
  Future<T?> get<T>({required String key});
  Future<bool> delete({required String key});
  Future<bool> clear();
}
