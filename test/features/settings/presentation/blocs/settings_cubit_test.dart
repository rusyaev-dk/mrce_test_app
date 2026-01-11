import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_template/features/settings/domain/domain.dart';
import 'package:flutter_app_template/features/settings/presentation/presentation.dart';
import 'package:flutter_app_template/features/theme_editor/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../core/utils/utils.dart';
import '../../../theme_editor/domain/interactors/mock_theme_editor_interactor.dart';
import '../../domain/interactors/mock_settings_interactor.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockSettingsInteractor mockSettingsInteractor;
  late MockThemeEditorInteractor mockThemeEditorInteractor;
  late MockLogger mockLogger;
  late AppTheme appTheme;

  setUp(() {
    mockSettingsInteractor = MockSettingsInteractor();
    mockThemeEditorInteractor = MockThemeEditorInteractor();
    mockLogger = MockLogger();
    appTheme = AppTheme.basic();
  });

  group('SettingsCubit', () {
    group('restoreSettings', () {
      blocTest<SettingsCubit, SettingsState>(
        'should emit [Loading, Loaded] when restore succeeds',
        build: () {
          when(
            () => mockSettingsInteractor.getCurrentLanguageCode(),
          ).thenAnswer((_) async => 'en');
          when(
            () => mockSettingsInteractor.getCurrentThemeMode(),
          ).thenAnswer((_) async => 'dark');
          when(
            () => mockThemeEditorInteractor.loadAppTheme(),
          ).thenAnswer((_) async => appTheme);

          return SettingsCubit(
            settingsInteractor: mockSettingsInteractor,
            themeConstructorInteractor: mockThemeEditorInteractor,
            logger: mockLogger,
          );
        },
        act: (bloc) => bloc.restoreSettings(),
        expect: () => [
          const SettingsLoadingState(),
          SettingsLoadedState(
            locale: const Locale('en'),
            themeMode: ThemeMode.dark,
            appTheme: appTheme,
          ),
        ],
        verify: (_) {
          verify(
            () => mockSettingsInteractor.getCurrentLanguageCode(),
          ).called(1);
          verify(() => mockSettingsInteractor.getCurrentThemeMode()).called(1);
          verify(() => mockThemeEditorInteractor.loadAppTheme()).called(1);
          verifyNever(() => mockLogger.exception(any(), any()));
        },
      );

      blocTest<SettingsCubit, SettingsState>(
        'should emit [Loading, Failure] when interactor throws exception',
        build: () {
          when(
            () => mockSettingsInteractor.getCurrentLanguageCode(),
          ).thenThrow(Exception('boom'));
          when(
            () => mockSettingsInteractor.getCurrentThemeMode(),
          ).thenAnswer((_) async => 'system');
          when(
            () => mockThemeEditorInteractor.loadAppTheme(),
          ).thenAnswer((_) async => appTheme);

          return SettingsCubit(
            settingsInteractor: mockSettingsInteractor,
            themeConstructorInteractor: mockThemeEditorInteractor,
            logger: mockLogger,
          );
        },
        act: (bloc) => bloc.restoreSettings(),
        expect: () => [
          const SettingsLoadingState(),
          isA<SettingsFailureState>(),
        ],
        verify: (_) {
          verify(() => mockLogger.exception(any(), any())).called(1);
        },
      );
    });

    group('changeLanguageCode', () {
      blocTest<SettingsCubit, SettingsState>(
        'does nothing when state is not Loaded',
        build: () {
          when(
            () => mockSettingsInteractor.getCurrentLanguageCode(),
          ).thenThrow(Exception('boom'));
          when(
            () => mockSettingsInteractor.getCurrentThemeMode(),
          ).thenAnswer((_) async => 'system');
          when(
            () => mockThemeEditorInteractor.loadAppTheme(),
          ).thenAnswer((_) async => appTheme);

          return SettingsCubit(
            settingsInteractor: mockSettingsInteractor,
            themeConstructorInteractor: mockThemeEditorInteractor,
            logger: mockLogger,
          );
        },
        act: (cubit) async {
          await cubit.restoreSettings();
          await cubit.changeLanguageCode(const Locale('ru'));
        },
        expect: () => [
          const SettingsLoadingState(),
          isA<SettingsFailureState>(),
        ],
        verify: (_) {
          verifyNever(
            () => mockSettingsInteractor.changeLanguage(
              newLanguageCode: any(named: 'newLanguageCode'),
            ),
          );
        },
      );

      blocTest<SettingsCubit, SettingsState>(
        'updates locale when changeLanguage returns true and locale differs',
        build: () {
          when(
            () => mockSettingsInteractor.getCurrentLanguageCode(),
          ).thenAnswer((_) async => 'en');
          when(
            () => mockSettingsInteractor.getCurrentThemeMode(),
          ).thenAnswer((_) async => 'system');
          when(
            () => mockThemeEditorInteractor.loadAppTheme(),
          ).thenAnswer((_) async => appTheme);

          when(
            () => mockSettingsInteractor.changeLanguage(newLanguageCode: 'ru'),
          ).thenAnswer((_) async => true);

          return SettingsCubit(
            settingsInteractor: mockSettingsInteractor,
            themeConstructorInteractor: mockThemeEditorInteractor,
            logger: mockLogger,
          );
        },
        act: (cubit) async {
          await cubit.restoreSettings();
          await cubit.changeLanguageCode(const Locale('ru'));
        },
        expect: () => <SettingsState>[
          const SettingsLoadingState(),
          SettingsLoadedState(
            locale: const Locale('en'),
            themeMode: ThemeMode.system,
            appTheme: appTheme,
          ),
          SettingsLoadedState(
            locale: const Locale('ru'),
            themeMode: ThemeMode.system,
            appTheme: appTheme,
          ),
        ],
        verify: (_) {
          verify(
            () => mockSettingsInteractor.changeLanguage(newLanguageCode: 'ru'),
          ).called(1);
          verifyNever(() => mockLogger.exception(any(), any()));
        },
      );

      blocTest<SettingsCubit, SettingsState>(
        'should emit Loaded with failure when changeLanguage returns false',
        build: () {
          when(
            () => mockSettingsInteractor.getCurrentLanguageCode(),
          ).thenAnswer((_) async => 'en');
          when(
            () => mockSettingsInteractor.getCurrentThemeMode(),
          ).thenAnswer((_) async => 'system');
          when(
            () => mockThemeEditorInteractor.loadAppTheme(),
          ).thenAnswer((_) async => appTheme);

          when(
            () => mockSettingsInteractor.changeLanguage(newLanguageCode: 'ru'),
          ).thenAnswer((_) async => false);

          return SettingsCubit(
            settingsInteractor: mockSettingsInteractor,
            themeConstructorInteractor: mockThemeEditorInteractor,
            logger: mockLogger,
          );
        },
        act: (cubit) async {
          await cubit.restoreSettings();
          await cubit.changeLanguageCode(const Locale('ru'));
        },
        expect: () => <dynamic>[
          const SettingsLoadingState(),
          isA<SettingsLoadedState>(),
          predicate<SettingsLoadedState>(
            (state) => state.failure is SettingsLocaleChangeException,
          ),
        ],
        verify: (_) {
          verify(
            () => mockSettingsInteractor.changeLanguage(newLanguageCode: 'ru'),
          ).called(1);
          verify(() => mockLogger.exception(any(), any())).called(1);
        },
      );

      blocTest<SettingsCubit, SettingsState>(
        'should emit Failure when changeLanguage throws exception',
        build: () {
          when(
            () => mockSettingsInteractor.getCurrentLanguageCode(),
          ).thenAnswer((_) async => 'en');
          when(
            () => mockSettingsInteractor.getCurrentThemeMode(),
          ).thenAnswer((_) async => 'system');
          when(
            () => mockThemeEditorInteractor.loadAppTheme(),
          ).thenAnswer((_) async => appTheme);

          when(
            () => mockSettingsInteractor.changeLanguage(newLanguageCode: 'ru'),
          ).thenThrow(Exception('boom'));

          return SettingsCubit(
            settingsInteractor: mockSettingsInteractor,
            themeConstructorInteractor: mockThemeEditorInteractor,
            logger: mockLogger,
          );
        },
        act: (cubit) async {
          await cubit.restoreSettings();
          await cubit.changeLanguageCode(const Locale('ru'));
        },
        expect: () => <dynamic>[
          const SettingsLoadingState(),
          isA<SettingsLoadedState>(),
          isA<SettingsFailureState>(),
        ],
        verify: (_) {
          verify(() => mockLogger.exception(any(), any())).called(1);
        },
      );
    });

    group('changeThemeMode', () {
      blocTest<SettingsCubit, SettingsState>(
        'updates themeMode when changeThemeMode returns true and mode differs',
        build: () {
          when(
            () => mockSettingsInteractor.getCurrentLanguageCode(),
          ).thenAnswer((_) async => 'en');
          when(
            () => mockSettingsInteractor.getCurrentThemeMode(),
          ).thenAnswer((_) async => 'system');
          when(
            () => mockThemeEditorInteractor.loadAppTheme(),
          ).thenAnswer((_) async => appTheme);

          when(
            () => mockSettingsInteractor.changeThemeMode(newThemeCode: 'dark'),
          ).thenAnswer((_) async => true);

          return SettingsCubit(
            settingsInteractor: mockSettingsInteractor,
            themeConstructorInteractor: mockThemeEditorInteractor,
            logger: mockLogger,
          );
        },
        act: (cubit) async {
          await cubit.restoreSettings();
          await cubit.changeThemeMode(ThemeMode.dark);
        },
        expect: () => <SettingsState>[
          const SettingsLoadingState(),
          SettingsLoadedState(
            locale: const Locale('en'),
            themeMode: ThemeMode.system,
            appTheme: appTheme,
          ),
          SettingsLoadedState(
            locale: const Locale('en'),
            themeMode: ThemeMode.dark,
            appTheme: appTheme,
          ),
        ],
        verify: (_) {
          verify(
            () => mockSettingsInteractor.changeThemeMode(newThemeCode: 'dark'),
          ).called(1);
          verifyNever(() => mockLogger.exception(any(), any()));
        },
      );

      blocTest<SettingsCubit, SettingsState>(
        'should emit Loaded with failure when changeThemeMode returns false',
        build: () {
          when(
            () => mockSettingsInteractor.getCurrentLanguageCode(),
          ).thenAnswer((_) async => 'en');
          when(
            () => mockSettingsInteractor.getCurrentThemeMode(),
          ).thenAnswer((_) async => 'system');
          when(
            () => mockThemeEditorInteractor.loadAppTheme(),
          ).thenAnswer((_) async => appTheme);

          when(
            () => mockSettingsInteractor.changeThemeMode(newThemeCode: 'dark'),
          ).thenAnswer((_) async => false);

          return SettingsCubit(
            settingsInteractor: mockSettingsInteractor,
            themeConstructorInteractor: mockThemeEditorInteractor,
            logger: mockLogger,
          );
        },
        act: (cubit) async {
          await cubit.restoreSettings();
          await cubit.changeThemeMode(ThemeMode.dark);
        },
        expect: () => <dynamic>[
          const SettingsLoadingState(),
          isA<SettingsLoadedState>(),
          predicate<SettingsLoadedState>(
            (state) => state.failure is SettingsThemeModeChangeException,
          ),
        ],
        verify: (_) {
          verify(() => mockLogger.exception(any(), any())).called(1);
        },
      );

      blocTest<SettingsCubit, SettingsState>(
        'does not emit new Loaded when new theme equals previous theme',
        build: () {
          when(
            () => mockSettingsInteractor.getCurrentLanguageCode(),
          ).thenAnswer((_) async => 'en');
          when(
            () => mockSettingsInteractor.getCurrentThemeMode(),
          ).thenAnswer((_) async => 'dark');
          when(
            () => mockThemeEditorInteractor.loadAppTheme(),
          ).thenAnswer((_) async => appTheme);

          when(
            () => mockSettingsInteractor.changeThemeMode(newThemeCode: 'dark'),
          ).thenAnswer((_) async => true);

          return SettingsCubit(
            settingsInteractor: mockSettingsInteractor,
            themeConstructorInteractor: mockThemeEditorInteractor,
            logger: mockLogger,
          );
        },
        act: (cubit) async {
          await cubit.restoreSettings();
          await cubit.changeThemeMode(ThemeMode.dark);
        },
        expect: () => <SettingsState>[
          const SettingsLoadingState(),
          SettingsLoadedState(
            locale: const Locale('en'),
            themeMode: ThemeMode.dark,
            appTheme: appTheme,
          ),
        ],
      );
    });
  });
}
