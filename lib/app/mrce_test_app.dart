import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:mrce_test_app/app/app.dart';
import 'package:mrce_test_app/core/core.dart';
import 'package:mrce_test_app/di/di.dart';
import 'package:mrce_test_app/features/error/error_screen.dart';
import 'package:mrce_test_app/features/splash/splash_screen.dart';
import 'package:mrce_test_app/uikit/uikit.dart';

class MRCETestApp extends StatefulWidget {
  const MRCETestApp({required this.initDependencies, super.key});

  final Future<AppScope> Function() initDependencies;

  @override
  State<MRCETestApp> createState() => _MRCETestAppState();
}

class _MRCETestAppState extends State<MRCETestApp> {
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
    final appThemeData = AppThemeData();
    return MaterialApp.router(
      scrollBehavior: const NoGlowClampingBehavior(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale(AppLanguages.ru),
      supportedLocales: AppLanguages.toLocalesList(),
      theme: appThemeData.getLightTheme(),
      darkTheme: appThemeData.getDarkTheme(),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
