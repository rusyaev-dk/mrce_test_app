import 'package:flutter/material.dart';
import 'package:flutter_app_template/features/home/presentation/presentation.dart';
import 'package:flutter_app_template/features/root/root_screen.dart';
import 'package:flutter_app_template/features/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter();

  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter createRouter({
    required bool includePrefixMatches,
    required List<NavigatorObserver> navigatorObservers,
  }) {
    return GoRouter(
      initialLocation: '/home',
      navigatorKey: rootNavigatorKey,

      debugLogDiagnostics: true,
      observers: navigatorObservers,
      routes: [
        ShellRoute(
          pageBuilder: buildShellPageTransition((
            BuildContext context,
            GoRouterState state,
            Widget child,
          ) {
            return RootScreen(child: child);
          }),
          routes: _routes,
        ),
      ],
    );
  }

  static final List<GoRoute> _routes = [
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, _) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, _) => const HomeScreen(),
    ),
  ];
}

Page<dynamic> Function(BuildContext, GoRouterState) buildPageTransition(
  Widget Function(BuildContext, GoRouterState) childBuilder,
) => (BuildContext context, GoRouterState state) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: childBuilder(context, state),
    transitionDuration: const Duration(milliseconds: 380),
    reverseTransitionDuration: const Duration(milliseconds: 260),
    transitionsBuilder: (context, animation, secondary, child) {
      final Animation<double> opacity = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );
      return FadeTransition(opacity: opacity, child: child);
    },
  );
};

Page<dynamic> Function(BuildContext, GoRouterState, Widget)
buildShellPageTransition(
  Widget Function(BuildContext, GoRouterState, Widget child) childBuilder,
) {
  return (BuildContext context, GoRouterState state, Widget child) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: childBuilder(context, state, child),
      transitionDuration: const Duration(milliseconds: 380),
      reverseTransitionDuration: const Duration(milliseconds: 260),
      transitionsBuilder: (context, animation, secondary, child) {
        final Animation<double> opacity = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
        return FadeTransition(opacity: opacity, child: child);
      },
    );
  };
}
