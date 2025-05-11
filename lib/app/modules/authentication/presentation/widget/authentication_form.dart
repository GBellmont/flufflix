import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flufflix/app/core/injection/injections.dart';

import 'package:flufflix/app/modules/shared/presentation/widget/widgets.dart';
import 'package:flufflix/app/modules/movie/presentation/page/pages.dart';

import 'package:flufflix/app/modules/authentication/presentation/event/events.dart';
import 'package:flufflix/app/modules/authentication/presentation/page/pages.dart';
import 'package:flufflix/app/modules/authentication/presentation/widget/widgets.dart';
import 'package:flufflix/app/modules/authentication/presentation/state/states.dart';
import 'package:flufflix/app/modules/authentication/presentation/bloc/blocs.dart';

class AuthenticationForm extends StatefulWidget {
  final bool isSignUp;

  const AuthenticationForm({required this.isSignUp, super.key});

  @override
  State<StatefulWidget> createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<AuthenticationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late final AuthenticationFormBloc _authenticationFormBloc;
  late final StreamSubscription<AuthenticationFormState> _authFormStateSub;

  @override
  void initState() {
    _authenticationFormBloc = getIt.get<AuthenticationFormBloc>();
    _authFormStateSub =
        _authenticationFormBloc.stream.listen(authStateListener);
    super.initState();
  }

  @override
  void dispose() {
    _authFormStateSub.cancel();
    _authenticationFormBloc.close();
    super.dispose();
  }

  void authStateListener(AuthenticationFormState state) {
    if (state is AuthenticationFormStateError) {
      ScaffoldMessenger.of(context).showSnackBar(StyledSnackBar(
          text: state.errorMessage, type: StyledSnackBarType.error));
    } else if (state is AuthenticationFormStateSignUpSucceeded) {
      ScaffoldMessenger.of(context).showSnackBar(StyledSnackBar(
          text:
              'Registration completed successfully!\nPlease wait while we redirect you...',
          type: StyledSnackBarType.success));
    } else if (state is AuthenticationFormStateLoginSucceeded) {
      context.go(HomePage.route);
    }
  }

  void onSubmitForm() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final username = _usernameController.text;
      final password = _passwordController.text;

      final event = widget.isSignUp
          ? PerformSignedUpAuthenticationEvent(
              email: email, password: password, username: username)
          : PerformLoginAuthenticationEvent(email: email, password: password);

      _authenticationFormBloc.add(event);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AuthenticationFormField(
                  controller: _emailController,
                  icon: Icons.email,
                  labelText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? value) {
                    final emailRegex = RegExp(
                        r"^(?!\.)(?!.*\.$)(?!.*\.\@)(?!.*@\.)[a-zA-Z0-9._%+-]+@[a-zA-Z]+\.(com)$");

                    return value != null &&
                            value.isNotEmpty &&
                            emailRegex.hasMatch(value)
                        ? null
                        : 'Invalid email!\nMust have at least:\n- one @;\n- one character before or after the @:\n- one ".com" after the @;\n- must not have a "." character before or after the @;';
                  }),
              Padding(
                padding: EdgeInsets.only(
                    top: widget.isSignUp ? 20 : 10,
                    bottom: widget.isSignUp ? 20 : 10),
                child: !widget.isSignUp
                    ? const SizedBox.shrink()
                    : AuthenticationFormField(
                        controller: _usernameController,
                        icon: Icons.person,
                        labelText: 'UserName',
                        keyboardType: TextInputType.name,
                        validator: (String? value) {
                          return value != null &&
                                  value.isNotEmpty &&
                                  value.length >= 6
                              ? null
                              : 'Invalid username!\nMust have at least:\n- six characters';
                        }),
              ),
              AuthenticationFormField(
                  controller: _passwordController,
                  icon: Icons.lock,
                  labelText: 'Password',
                  keyboardType: TextInputType.visiblePassword,
                  isPasswordInput: true,
                  validator: (String? value) {
                    final passwordRegex = RegExp(
                        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$');

                    return value != null &&
                            value.isNotEmpty &&
                            passwordRegex.hasMatch(value)
                        ? null
                        : 'Invalid password!\nMust have at least:\n- eight characters;\n- one uppercase character;\n- one lowercase character;\n- one number;\n- one special character;';
                  }),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: BlocBuilder<AuthenticationFormBloc,
                        AuthenticationFormState>(
                    bloc: _authenticationFormBloc,
                    builder: (context, state) {
                      switch (state) {
                        case AuthenticationFormStateInitial():
                          return StyledButton(
                              onPressed: onSubmitForm,
                              text:
                                  widget.isSignUp ? 'Create Account' : 'Login');
                        case AuthenticationFormStateLoading():
                          return StyledButton(
                              onPressed: () {}, isLoading: true, text: '');
                        case AuthenticationFormStateError():
                          return StyledButton(
                              onPressed: onSubmitForm,
                              isError: true,
                              text: 'Retry');
                        case AuthenticationFormStateLoginSucceeded():
                          return StyledButton(
                              onPressed: () {}, isLoading: true, text: '');
                        case AuthenticationFormStateSignUpSucceeded():
                          return StyledButton(
                              onPressed: () {}, isLoading: true, text: '');
                      }
                    }),
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: widget.isSignUp
                        ? 'Already have an account? '
                        : 'Haven’t made an account? '),
                TextSpan(
                    text: widget.isSignUp ? 'Login' : 'Sign Up',
                    style: const TextStyle(
                      color: Color.fromRGBO(149, 172, 255, 1),
                      fontWeight: FontWeight.w500,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.go(AuthenticationPage.route(
                            isSignUp: !widget.isSignUp));
                      })
              ]))
            ],
          ),
        ));
  }
}
