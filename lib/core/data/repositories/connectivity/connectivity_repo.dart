import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

abstract interface class IConnectivityRepo {
  Future<bool> isOnline();
  Stream<bool> watchIsOnline();
}

class ConnectivityPlusRepo implements IConnectivityRepo {
  ConnectivityPlusRepo({Connectivity? connectivity})
    : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  @override
  Future<bool> isOnline() async {
    final statuses = await _connectivity.checkConnectivity();
    if (!_hasNetworkInterface(statuses)) return false;
    return _hasReachableInternet();
  }

  @override
  Stream<bool> watchIsOnline() {
    return _connectivity.onConnectivityChanged
        .asyncMap((statuses) async {
          if (!_hasNetworkInterface(statuses)) return false;
          return _hasReachableInternet();
        })
        .distinct();
  }

  bool _hasNetworkInterface(List<ConnectivityResult> statuses) {
    return statuses.any((status) => status != ConnectivityResult.none);
  }

  Future<bool> _hasReachableInternet() async {
    try {
      final result = await InternetAddress.lookup(
        'one.one.one.one',
      ).timeout(const Duration(seconds: 3));
      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } on Object {
      return false;
    }
  }
}
