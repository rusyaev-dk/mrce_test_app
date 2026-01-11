import 'package:flutter_app_template/core/data/storage/storage.dart';

class StorageAggregator {
  StorageAggregator({
    required this.secureStorage,
    required this.localKeyValueStorage,
  });

  final IKeyValueStorage secureStorage;
  final IKeyValueStorage localKeyValueStorage;

  IKeyValueStorage get secure => secureStorage;
  IKeyValueStorage get prefs => localKeyValueStorage;
}
