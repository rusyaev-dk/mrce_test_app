import 'package:mrce_test_app/core/core.dart';

class StorageAggregator {
  StorageAggregator({
    required this.localKeyValueStorage,
    required this.hiveBoxes,
  });

  final LocalKeyValueStorage localKeyValueStorage;
  final HiveBoxes hiveBoxes;
}
