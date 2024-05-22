import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:protest/features/ui/splash/presentation/onboard_screen.dart';
import 'package:protest/features/ui/splash/presentation/splash_screen.dart';

class Routes {
  Routes._();

  static String get splash => '/splash_screen';

  static String get onboard => '/onboard';

  static String get login => '/login';

  static String get home => '/login';

  static String get rating => '/rating';

  static String get library => '/library';

  static String get profile => '/profile';
}

class AppRoutes {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');
  static final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'shell');
  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: Routes.splash,

    ///splash
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: Routes.splash,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: Routes.onboard,
        builder: (BuildContext context, GoRouterState state) {
          return const OnboardScreen();
        },
      ),
      // ShellRoute(
      //   navigatorKey: _shellNavigatorKey,
      //   builder: (BuildContext context, GoRouterState state, Widget child) {
      //     return MainPage(
      //       child: child,
      //     );
      //   },
      //   routes: <RouteBase>[
      //     GoRoute(
      //       path: Routes.home,
      //       builder: (BuildContext context, GoRouterState state) {
      //         return const HomePage();
      //       },
      //     ),
      //   ],
      // ),
    ],
  );

  static int calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    int selIndex = 0;

    if (location.startsWith(Routes.home)) {
      selIndex = 0;
    }
    if (location.startsWith(Routes.rating)) {
      selIndex = 1;
    }
    if (location.startsWith(Routes.profile)) {
      selIndex = 4;
    }
    return selIndex;
  }

  static void onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go(Routes.home);
        break;
      case 1:
        GoRouter.of(context).go(Routes.rating);
        break;
      case 4:
        GoRouter.of(context).go(Routes.profile);
        break;
    }
  }
}

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 0),
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}
