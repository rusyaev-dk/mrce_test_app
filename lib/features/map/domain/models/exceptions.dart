import 'package:mrce_test_app/core/core.dart';

abstract class MapException extends DomainException {
  MapException({required super.message, super.error, super.stackTrace});
}

final class MapNoInternetException extends MapException {
  MapNoInternetException({
    required super.message,
    super.error,
    super.stackTrace,
  }) : super();
}

final class MapTimeoutException extends MapException {
  MapTimeoutException({required super.message, super.error, super.stackTrace})
    : super();
}

final class MapAddressNotFoundException extends MapException {
  MapAddressNotFoundException({
    required super.message,
    super.error,
    super.stackTrace,
  }) : super();
}

final class MapInvalidResponseException extends MapException {
  MapInvalidResponseException({
    required super.message,
    super.error,
    super.stackTrace,
  }) : super();
}

final class MapServiceUnavailableException extends MapException {
  MapServiceUnavailableException({
    required super.message,
    super.error,
    super.stackTrace,
  }) : super();
}
