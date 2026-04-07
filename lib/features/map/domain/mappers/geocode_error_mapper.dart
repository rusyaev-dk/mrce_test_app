import 'dart:async';
import 'dart:io';

import 'package:mrce_test_app/features/map/domain/models/exceptions.dart';

class GeocodeErrorMapper {
  static MapException mapRepoError(Object error, StackTrace stackTrace) {
    if (error is MapException) return error;

    if (error is SocketException ||
        _containsAny(error, ['socket', 'network', 'internet'])) {
      return MapNoInternetException(
        message: 'No internet connection',
        error: error,
        stackTrace: stackTrace,
      );
    }

    if (error is TimeoutException ||
        _containsAny(error, ['timeout', 'timed out'])) {
      return MapTimeoutException(
        message: 'Geocoder response timed out',
        error: error,
        stackTrace: stackTrace,
      );
    }

    if (error is FormatException ||
        _containsAny(error, ['invalid response', 'missing in response'])) {
      if (_containsAny(error, ['not found', 'address not found'])) {
        return MapAddressNotFoundException(
          message: 'Address not found',
          error: error,
          stackTrace: stackTrace,
        );
      }

      return MapInvalidResponseException(
        message: 'Received invalid geocoder response',
        error: error,
        stackTrace: stackTrace,
      );
    }

    if (_containsAny(error, ['not found', 'address not found'])) {
      return MapAddressNotFoundException(
        message: 'Address not found',
        error: error,
        stackTrace: stackTrace,
      );
    }

    return MapServiceUnavailableException(
      message: 'Geocoding service is temporarily unavailable',
      error: error,
      stackTrace: stackTrace,
    );
  }

  static bool _containsAny(Object error, List<String> parts) {
    final value = error.toString().toLowerCase();
    return parts.any(value.contains);
  }
}
