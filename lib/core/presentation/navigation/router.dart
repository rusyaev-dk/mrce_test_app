import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mrce_test_app/features/map/presentation/presentation.dart';
import 'package:mrce_test_app/features/root/root_screen.dart';
import 'package:mrce_test_app/features/splash/splash_screen.dart';

class AppRouter {
  AppRouter();

  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter createRouter({
    required bool includePrefixMatches,
    required List<NavigatorObserver> navigatorObservers,
  }) {
    return GoRouter(
      initialLocation: '/',
      navigatorKey: rootNavigatorKey,
      debugLogDiagnostics: true,
      observers: navigatorObservers,
      routes: [
        GoRoute(
          path: '/',
          name: 'splash',
          builder: (context, _) => const SplashScreen(),
        ),
        ShellRoute(
          pageBuilder: buildShellPageTransition((
            BuildContext context,
            GoRouterState state,
            Widget child,
          ) {
            return RootScreen(child: child);
          }),
          routes: [
            GoRoute(
              path: '/home',
              name: 'home',
              builder: (context, _) => const HomeScreen(),
            ),
          ],
        ),
      ],
    );
  }
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
