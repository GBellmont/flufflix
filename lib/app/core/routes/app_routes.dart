import 'package:go_router/go_router.dart';

import 'package:flufflix/app/modules/content/presentation/page/pages.dart';
import 'package:flufflix/app/modules/content/presentation/enum/enums.dart';
import 'package:flufflix/app/modules/authentication/presentation/page/pages.dart';

class AppRoutes {
  static final GoRouter routes = GoRouter(
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
          path: AuthenticationPage.route(isSignUp: true),
          builder: (context, state) {
            return const AuthenticationPage(
              isSignUp: true,
            );
          },
        ),
        GoRoute(
          path: AuthenticationPage.route(),
          builder: (context, state) {
            return const AuthenticationPage();
          },
        ),
        GoRoute(
          path: ContentDetailsPage.route,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            final title = extra['title'];
            final posterImage = extra['posterImage'];
            final type = extra['type'];

            final id = state.pathParameters['id'] ?? "";
            return ContentDetailsPage(
              id: id,
              title: title,
              posterImage: posterImage,
              type: ContentTypeEnum.fromString[type]!,
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
}
