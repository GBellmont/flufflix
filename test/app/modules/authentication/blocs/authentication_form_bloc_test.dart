import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flufflix/app/modules/authentication/presentation/bloc/blocs.dart';
import 'package:flufflix/app/modules/authentication/presentation/event/events.dart';
import 'package:flufflix/app/modules/authentication/presentation/state/states.dart';

const String fakeEmail = 'luan.barcella@gmail.com';
const String fakePassword = '12345678';

void main() {
  group('AuthenticationFormBlocTest', () {
    group('Login', () {
      blocTest<AuthenticationFormBloc, AuthenticationFormState>(
        'emite [AuthenticationFormStateLoginSucceeded] ao realizar o login com sucesso',
        build: () => AuthenticationFormBloc(),
        act: (bloc) => bloc.add(const PerformLoginAuthenticationEvent(
            email: fakeEmail, password: fakePassword)),
        expect: () => [
          AuthenticationFormStateLoading(),
          AuthenticationFormStateLoginSucceeded()
        ],
        wait: const Duration(seconds: 4),
      );
    });

    group('SignUp', () {
      blocTest<AuthenticationFormBloc, AuthenticationFormState>(
        'emite [AuthenticationFormStateSignUpSucceeded && AuthenticationFormStateLoginSucceeded] ao realizar o cadastro com sucesso',
        build: () => AuthenticationFormBloc(),
        act: (bloc) => bloc.add(const PerformSignedUpAuthenticationEvent(
            email: fakeEmail, password: fakePassword, username: 'username')),
        expect: () => [
          AuthenticationFormStateLoading(),
          AuthenticationFormStateSignUpSucceeded(),
          AuthenticationFormStateLoading(),
          AuthenticationFormStateLoginSucceeded(),
        ],
        wait: const Duration(seconds: 10),
      );
    });

    group('AuthenticationFormStateError', () {
      test('deve criar state de erro corretamente', () {
        const errorMessage = 'Error Message';
        const errorState =
            AuthenticationFormStateError(errorMessage: errorMessage);

        expect(errorState.errorMessage, errorMessage);
        expect(errorState.props, [errorMessage]);
      });
    });
  });
}
