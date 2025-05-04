import 'package:flutter/material.dart';

import 'package:flufflix/components/form/authentication/authentication_form.dart';

class SignUpPage extends StatefulWidget {
  static const String route = '/signup';

  const SignUpPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 60),
              child: Text('Sign Up',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  )),
            ),
            AuthenticationForm(
              isSignUp: true,
            )
          ],
        ),
      ),
    );
  }
}
