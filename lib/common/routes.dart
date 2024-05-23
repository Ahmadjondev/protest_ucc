import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:protest/features/ui/home/presentation/home_screen.dart';
import 'package:protest/features/ui/leaderboard/presentation/leaderboard_screen.dart';
import 'package:protest/features/ui/library/presentation/library_screen.dart';
import 'package:protest/features/ui/main/presentation/main_screen.dart';
import 'package:protest/features/ui/profile/presentation/profile_screen.dart';
import 'package:protest/features/ui/splash/presentation/onboard_screen.dart';
import 'package:protest/features/ui/splash/presentation/splash_screen.dart';
import 'package:protest/features/ui/uzbmb/presentation/uzbmb_quiz_screen.dart';
import 'package:protest/features/ui/uzbmb/presentation/uzbmb_screen.dart';

class Routes {
  Routes._();

  static String get splash => '/splash_screen';

  static String get onboard => '/onboard';

  static String get login => '/login';

  static String get home => '/login';

  static String get rating => '/rating';

  static String get library => '/library';

  static String get profile => '/profile';

  static String get uzbmb => '/uzbmb';

  static String get uzbmbStart => '/uzbmb_start';
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
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: Routes.uzbmb,
        builder: (BuildContext context, GoRouterState state) {
          return UzbmbScreen();
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: Routes.uzbmbStart,
        builder: (BuildContext context, GoRouterState state) {
          var id = state.extra as int;
          return UzbmbQuizScreen(
            id: id,
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: rootNavigatorKey,
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: "Home",
                path: Routes.home,
                pageBuilder: (context, state) {
                  return buildPageWithDefaultTransition(
                      context: context, child: HomeScreen(), state: state);
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.rating,
                name: "Rating",
                pageBuilder: (context, state) {
                  return buildPageWithDefaultTransition(
                      context: context,
                      child: const LeaderboardScreen(),
                      state: state);
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.library,
                name: "Library",
                pageBuilder: (context, state) {
                  return buildPageWithDefaultTransition(
                      context: context,
                      child: const LibraryScreen(),
                      state: state);
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.profile,
                name: "Profile",
                pageBuilder: (context, state) {
                  return buildPageWithDefaultTransition(
                      context: context,
                      child: const ProfileScreen(),
                      state: state);
                },
                builder: (BuildContext context, GoRouterState state) {
                  return const ProfileScreen();
                },
              ),
            ],
          )
        ],
        pageBuilder: (context, state, navigationShell) {
          return buildPageWithDefaultTransition(
              context: context,
              child: MainScreen(child: navigationShell),
              state: state);
        },
      ),
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
