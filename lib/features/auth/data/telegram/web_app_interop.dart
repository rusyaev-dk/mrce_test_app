@JS()
library;

import 'package:js/js.dart';

@JS('Telegram')
external TelegramNamespace? get telegram;

@JS()
@anonymous
class TelegramNamespace {
  @JS('WebApp')
  external WebApp? get webApp;
}

@JS()
@anonymous
class WebApp {
  external String get initData;
  external InitDataUnsafe? get initDataUnsafe;
  external void ready();
  external void expand();
}

@JS()
@anonymous
class InitDataUnsafe {
  external TgUser? get user;
}

@JS()
@anonymous
class TgUser {
  external int get id;
  external String? get first_name;
  external String? get last_name;
  external String? get username;
  external String? get language_code;
  external bool? get is_premium;
}
