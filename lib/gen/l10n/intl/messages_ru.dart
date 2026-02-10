// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "apiForbiddenException": MessageLookupByLibrary.simpleMessage(
      "Доступ запрещён, у вас нет прав для выполнения этого действия",
    ),
    "apiNotFoundException": MessageLookupByLibrary.simpleMessage(
      "Запрашиваемый ресурс не найден",
    ),
    "apiServerException": MessageLookupByLibrary.simpleMessage(
      "Ошибка сервера, попробуйте позже",
    ),
    "apiTimeoutException": MessageLookupByLibrary.simpleMessage(
      "Время ожидания запроса истекло, повторите попытку",
    ),
    "apiUnauthorizedException": MessageLookupByLibrary.simpleMessage(
      "Ошибка авторизации, пожалуйста, войдите снова",
    ),
    "apiValidationException": MessageLookupByLibrary.simpleMessage(
      "Ошибка валидации данных, проверьте введённую информацию",
    ),
    "appException": MessageLookupByLibrary.simpleMessage(
      "Произошла ошибка приложения",
    ),
    "appUnknownException": MessageLookupByLibrary.simpleMessage(
      "Произошла неизвестная ошибка",
    ),
    "apply": MessageLookupByLibrary.simpleMessage("Применить"),
    "authException": MessageLookupByLibrary.simpleMessage("Ошибка авторизации"),
    "authInvalidCredentialsException": MessageLookupByLibrary.simpleMessage(
      "Неверные учетные данные, проверьте логин или пароль",
    ),
    "authUnauthorizedException": MessageLookupByLibrary.simpleMessage(
      "Вы не авторизованы, пожалуйста, войдите снова",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Назад"),
    "cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
    "charactersCountViolationException": MessageLookupByLibrary.simpleMessage(
      "Недопустимое количество символов",
    ),
    "clear": MessageLookupByLibrary.simpleMessage("Очистить"),
    "close": MessageLookupByLibrary.simpleMessage("Закрыть"),
    "confirm": MessageLookupByLibrary.simpleMessage("Подтвердить"),
    "delete": MessageLookupByLibrary.simpleMessage("Удалить"),
    "edit": MessageLookupByLibrary.simpleMessage("Редактировать"),
    "inconsistentValueException": MessageLookupByLibrary.simpleMessage(
      "Некорректное значение",
    ),
    "invalidCharactersException": MessageLookupByLibrary.simpleMessage(
      "Введены некорректные символы",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Язык"),
    "next": MessageLookupByLibrary.simpleMessage("Далее"),
    "ok": MessageLookupByLibrary.simpleMessage("ОК"),
    "requiredValueNotProvidedException": MessageLookupByLibrary.simpleMessage(
      "Обязательно для заполнения",
    ),
    "reset": MessageLookupByLibrary.simpleMessage("Сбросить"),
    "save": MessageLookupByLibrary.simpleMessage("Сохранить"),
    "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
    "share": MessageLookupByLibrary.simpleMessage("Поделиться"),
    "storageException": MessageLookupByLibrary.simpleMessage(
      "Ошибка хранилища",
    ),
    "storageIOException": MessageLookupByLibrary.simpleMessage(
      "Ошибка чтения/записи в хранилище",
    ),
    "themeMode": MessageLookupByLibrary.simpleMessage("Тема"),
    "themeModeDark": MessageLookupByLibrary.simpleMessage("Тёмная"),
    "themeModeLight": MessageLookupByLibrary.simpleMessage("Светлая"),
    "themeModeSystem": MessageLookupByLibrary.simpleMessage("Системная"),
  };
}
