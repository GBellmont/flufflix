import 'package:flutter/material.dart';

import 'package:flufflix/app/modules/authentication/presentation/widget/widgets.dart';

class AuthenticationPage extends StatelessWidget {
  static String route({bool isSignUp = false}) {
    return isSignUp ? '/signup' : '/login';
  }

  final bool isSignUp;

  const AuthenticationPage({super.key, this.isSignUp = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Text(isSignUp ? 'Sign Up' : 'Login',
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  )),
            ),
            AuthenticationForm(
              isSignUp: isSignUp,
            )
          ],
        ),
      ),
    );
  }
}
