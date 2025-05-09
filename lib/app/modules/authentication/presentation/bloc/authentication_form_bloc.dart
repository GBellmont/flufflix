import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flufflix/app/modules/authentication/presentation/event/events.dart';
import 'package:flufflix/app/modules/authentication/presentation/state/states.dart';

class AuthenticationFormBloc
    extends Bloc<AuthenticationFormEvent, AuthenticationFormState> {
  AuthenticationFormBloc() : super(AuthenticationFormStateInitial()) {
    on<PerformLoginAuthenticationEvent>(_performLogin);
    on<PerformSignedUpAuthenticationEvent>(_performSignUp);
  }

  Future<void> _performLogin(
      PerformLoginAuthenticationEvent event, Emitter emit) async {
    emit(AuthenticationFormStateLoading());

    log('Realizando lógica de login com: email -> ${event.email} e password -> ${event.password}.');
    await Future.delayed(const Duration(seconds: 3));

    emit(AuthenticationFormStateLoginSucceeded());
  }

  Future<void> _performSignUp(
      PerformSignedUpAuthenticationEvent event, Emitter emit) async {
    emit(AuthenticationFormStateLoading());

    log('Realizando lógica de cadastro com: email -> ${event.email}, password -> ${event.password} e username -> ${event.username}.');
    await Future.delayed(const Duration(seconds: 2));

    emit(AuthenticationFormStateSignUpSucceeded());
    await Future.delayed(const Duration(seconds: 3));

    await _performLogin(
        PerformLoginAuthenticationEvent(
            email: event.email, password: event.password),
        emit);
  }
}
