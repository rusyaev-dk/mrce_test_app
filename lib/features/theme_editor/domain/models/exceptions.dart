import 'package:flutter_app_template/core/core.dart';

abstract class ThemeConstructorException extends DomainException {
  ThemeConstructorException({
    required super.message,
    super.error,
    super.stackTrace,
  });
}

final class ThemeConstructorUpdateThemeException
    extends ThemeConstructorException {
  ThemeConstructorUpdateThemeException({
    required super.message,
    super.error,
    super.stackTrace,
  });
}
