import 'package:flutter/material.dart';
import 'package:flutter_app_template/app/app.dart';
import 'package:flutter_app_template/core/core.dart';
import 'package:flutter_app_template/di/di.dart';
import 'package:flutter_app_template/features/error/error_screen.dart';
import 'package:flutter_app_template/features/settings/presentation/presentation.dart';
import 'package:flutter_app_template/features/splash/splash_screen.dart';
import 'package:flutter_app_template/l10n/generated/l10n.dart';
import 'package:flutter_app_template/uikit/themes/app_theme_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

class TemplateApp extends StatefulWidget {
  const TemplateApp({
    required this.router,
    required this.initDependencies,
    super.key,
  });

  final GoRouter router;
  final Future<AppScope> Function() initDependencies;

  @override
  State<TemplateApp> createState() => _TemplateAppState();
}

class _TemplateAppState extends State<TemplateApp> {
  late Future<AppScope> _initFuture;

  @override
  void initState() {
    super.initState();
    _initFuture = widget.initDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppScope>(
      future: _initFuture,
      builder: (_, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            // Пока инициализация показываем Splash
            return const SplashScreen();
          case ConnectionState.done:
            if (snapshot.hasError) {
              return ErrorScreen(
                error: snapshot.error,
                stackTrace: snapshot.stackTrace,
                onRetry: _retryInit,
              );
            }

            final appScope = snapshot.data;
            if (appScope == null) {
              return ErrorScreen(
                error: 'Error initializing dependencies: diContainer = null',
                stackTrace: null,
                onRetry: _retryInit,
              );
            }
            return AppProvidersWrapper(
              appScope: appScope,
              child: _App(router: widget.router),
            );
        }
      },
    );
  }

  void _retryInit() {
    setState(() {
      _initFuture = widget.initDependencies();
    });
  }
}

class _App extends StatelessWidget {
  const _App({required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SettingsCubit, SettingsState, (Locale, ThemeMode)>(
      selector: (state) {
        switch (state) {
          case SettingsLoadedState():
            return (state.locale, state.themeMode);
          default:
            return (const Locale('ru'), ThemeMode.system);
        }
      },
      builder: (context, tuple) {
        final (locale, themeMode) = tuple;

        return MaterialApp.router(
          scrollBehavior: const NoGlowClampingBehavior(),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: locale,
          supportedLocales: const [Locale('ru'), Locale('uz')],
          theme: AppThemeData.lightTheme,
          darkTheme: AppThemeData.darkTheme,
          themeMode: themeMode,
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        );
      },
    );
  }
}
