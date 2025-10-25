import 'package:flutter_app_template/core/core.dart';

enum SessionErrorType implements IMessageKey {
  loadFail('load_fail'),
  expired('expired'),
  invalid('invalid'),
  unauthorized('unauthorized');

  const SessionErrorType(this.value);
  final String value;

  @override
  String toString() => value;

  factory SessionErrorType.fromString(String value) =>
      SessionErrorType.values.firstWhere(
        (e) => e.value == value,
        orElse: () => throw ArgumentError('Unknown SessionErrorType: $value'),
      );
}
