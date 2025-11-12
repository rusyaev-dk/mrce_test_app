import 'package:flutter_app_template/app/app.dart';

abstract class DomainException extends AppException {
  DomainException({required super.message, super.error, super.stackTrace});
}
