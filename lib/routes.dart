import 'package:go_router/go_router.dart';

import 'package:flufflix/pages/index.dart';

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
      GoRoute(
        path: SignUpPage.route,
        builder: (context, state) {
          return const SignUpPage();
        },
      ),
      GoRoute(
        path: LoginPage.route,
        builder: (context, state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: ContentDetailsPage.route,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final title = extra['title'];
          final posterImage = extra['posterImage'];

          final id = state.pathParameters['id'] ?? "";
          return ContentDetailsPage(
            id: id,
            title: title,
            posterImage: posterImage,
          );
        },
      ),
      ShellRoute(
          builder: (context, state, child) {
            final index = state.extra ?? 0;

            return HomeWrapperPage(
              index: index as int,
              child: child,
            );
          },
          routes: [
            GoRoute(
              path: HomePage.route,
              builder: (context, state) => const HomePage(),
            ),
            GoRoute(
              path: '/search',
              builder: (context, state) => const HomePage(),
            ),
            GoRoute(
              path: '/favorites',
              builder: (context, state) => const HomePage(),
            ),
            GoRoute(
              path: '/config',
              builder: (context, state) => const HomePage(),
            )
          ])
    ]);
