import 'package:flutter/material.dart';
import 'package:flutter_app_template/app/app.dart';
import 'package:flutter_app_template/core/core.dart';
import 'package:flutter_app_template/di/di.dart';
import 'package:flutter_app_template/features/auth/presentation/presentation.dart';
import 'package:flutter_app_template/features/error/error_screen.dart';
import 'package:flutter_app_template/features/settings/presentation/presentation.dart';
import 'package:flutter_app_template/features/splash/splash_screen.dart';
import 'package:flutter_app_template/features/theme_editor/domain/domain.dart';
import 'package:flutter_app_template/gen/gen.dart';
import 'package:flutter_app_template/uikit/uikit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

class TemplateApp extends StatefulWidget {
  const TemplateApp({required this.initDependencies, super.key});

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
              child: Builder(
                builder: (context) {
                  final router = AppRouter.createRouter(
                    includePrefixMatches: true,
                    navigatorObservers: [appScope.routeObserver],
                    authListenable: AuthRouterListenable(
                      authCubit: context.read<AuthCubit>(),
                    ),
                  );
                  return _App(router: router);
                },
              ),
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
    return BlocSelector<
      SettingsCubit,
      SettingsState,
      (Locale, ThemeMode, AppTheme)
    >(
      selector: (state) {
        switch (state) {
          case SettingsLoadedState():
            return (state.locale, state.themeMode, state.appTheme);
          default:
            return (
              const Locale(AppLanguages.ru),
              ThemeMode.system,
              AppTheme.basic(),
            );
        }
      },
      builder: (context, tuple) {
        final (locale, themeMode, appTheme) = tuple;
        final appThemeData = AppThemeData(
          lightScheme: appTheme.lightPalette.toColorScheme(
            const AppColorScheme.light(),
          ),
          darkScheme: appTheme.darkPalette.toColorScheme(
            const AppColorScheme.dark(),
          ),
        );

        return MaterialApp.router(
          scrollBehavior: const NoGlowClampingBehavior(),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: locale,
          supportedLocales: AppLanguages.toLocalesList(),
          theme: appThemeData.getLightTheme(),
          darkTheme: appThemeData.getDarkTheme(),
          themeMode: themeMode,
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        );
      },
    );
  }
}
