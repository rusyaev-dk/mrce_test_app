abstract interface class IMessageKey {}

enum GlobalMessageType implements IMessageKey {
  unknownError('unknown_error'),
  noInternet('no_internet'),
  requestTimeout('request_timeout'),
  unauthorized('unauthorized');

  const GlobalMessageType(this.value);
  final String value;

  @override
  String toString() => value;

  factory GlobalMessageType.fromString(String value) =>
      GlobalMessageType.values.firstWhere(
        (e) => e.value == value,
        orElse: () => throw ArgumentError('Unknown GlobalMessageKey: $value'),
      );
}
