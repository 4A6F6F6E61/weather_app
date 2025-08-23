import 'package:weather_app/main.dart';
import 'package:weather_app/navigator_page.dart';
import 'package:weather_app/pages/about_page.dart';
import 'package:weather_app/pages/home_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final _shellNavigatorAboutKey = GlobalKey<NavigatorState>(debugLabel: 'shellAbout');

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: "/home",
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (_, _, navigationShell) {
        return NavigatorPage(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            // Go router doesn't allow the default route to be parameterized,
            // so I just add an extra route for the default Location.
            GoRoute(
              path: '/home',
              builder: (_, _) => HomePage(locationString: defaultLocation),
            ),
            GoRoute(
              path: '/home/:location',
              builder: (_, state) => HomePage(
                // Use UniqueKey to force go_router to rebuild when you just change the location
                key: UniqueKey(),
                locationString: state.pathParameters['location']!,
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAboutKey,
          routes: [GoRoute(path: '/about', builder: (_, _) => AboutPage())],
        ),
      ],
    ),
  ],
);
