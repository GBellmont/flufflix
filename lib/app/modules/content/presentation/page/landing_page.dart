import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flufflix/app/modules/shared/presentation/widget/widgets.dart';
import 'package:flufflix/app/modules/authentication/presentation/page/pages.dart';

class LandingPage extends StatelessWidget {
  static const String route = '/landing-page';

  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Material(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned.fill(
              child: Image.asset("assets/images/the_last_jedi.png",
                  fit: BoxFit.cover)),
          Container(
            height: size.height * .37,
            width: size.width,
            padding: const EdgeInsets.symmetric(vertical: 29, horizontal: 19),
            decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.8),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Watch movies anytime anywhere",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 20),
                  child: Text(
                    "Explore a vast collection of blockbuster movies, timeless classics, and the latest releases.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
                StyledButton(
                    onPressed: () => context.go(AuthenticationPage.route()),
                    text: "Login"),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: StyledButton(
                      onPressed: () =>
                          context.go(AuthenticationPage.route(isSignUp: true)),
                      text: "Sign Up",
                      primary: false),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
