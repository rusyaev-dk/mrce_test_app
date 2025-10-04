part of 'settings_cubit.dart';

sealed class SettingsState extends Equatable {}

final class SettingsInitialState extends SettingsState {
  @override
  List<Object?> get props => [];
}

final class SettingsLoadingState extends SettingsState {
  @override
  List<Object?> get props => [];
}

final class SettingsLoadedState extends SettingsState {
  SettingsLoadedState({
    required this.locale,
    required this.themeMode,
    this.message,
  });

  final Locale locale;
  final ThemeMode themeMode;
  final AppMessage? message;

  SettingsLoadedState copyWith({
    Locale? locale,
    ThemeMode? themeMode,
    AppMessage? message,
  }) {
    return SettingsLoadedState(
      locale: locale ?? this.locale,
      themeMode: themeMode ?? this.themeMode,
      message: message,
    );
  }

  @override
  List<Object> get props => [locale, themeMode];
}

final class SettingsFailureState extends SettingsState {
  SettingsFailureState({required this.failure, this.message});

  final Object failure;
    final AppMessage? message;

  @override
  List<Object?> get props => [failure, message];
}
