import 'package:flufflix/pages/index.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
    initialLocation: LandingPage.route,
    //redirect: (context, state) {}, //-> Equivalente a um middleware utilizar para verificar autenticação.
    routes: [
      GoRoute(
        path: LandingPage.route,
        builder: (context, state) {
          return const LandingPage();
        },
      ),
      ShellRoute(
          builder: (context, state, child) {
            final index = state.extra ?? 0;

            return HomePage(
              index: index as int,
              child: child,
            );
          },
          routes: [
            GoRoute(
              path: HomePage.route,
              builder: (context, state) => const InitialPage(),
            ),
            GoRoute(
              path: '/search',
              builder: (context, state) => const InitialPage(),
            ),
            GoRoute(
              path: '/favorites',
              builder: (context, state) => const InitialPage(),
            ),
            GoRoute(
              path: '/config',
              builder: (context, state) => const InitialPage(),
            )
          ])
    ]);
