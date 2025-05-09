import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flufflix/app/modules/authentication/presentation/bloc/blocs.dart';
import 'package:flufflix/app/modules/authentication/presentation/event/events.dart';
import 'package:flufflix/app/modules/authentication/presentation/state/states.dart';

void main() {
  group('AuthenticationFormFieldBlocTest', () {
    blocTest<AuthenticationFormFieldBloc, AuthenticationFormFieldState>(
      'emite [AuthFormFieldErrorState] ao receber SetAuthFormFieldValidatedErrorEvent',
      build: () => AuthenticationFormFieldBloc(),
      act: (bloc) => bloc.add(
          const SetAuthFormFieldValidatedErrorEvent(visibleInputContent: true)),
      expect: () => [
        const AuthFormFieldErrorState(isVisibleContent: true),
      ],
    );

    blocTest<AuthenticationFormFieldBloc, AuthenticationFormFieldState>(
      'não emite [AuthFormFieldErrorState] se o estado atual for AuthFormFieldErrorState',
      build: () => AuthenticationFormFieldBloc(),
      act: (bloc) {
        bloc.add(const SetAuthFormFieldValidatedErrorEvent(
            visibleInputContent: true));
        bloc.add(const SetAuthFormFieldValidatedErrorEvent(
            visibleInputContent: true));
      },
      expect: () => [const AuthFormFieldErrorState(isVisibleContent: true)],
    );

    blocTest<AuthenticationFormFieldBloc, AuthenticationFormFieldState>(
      'emite [AuthFormFieldSuccessState] ao receber SetAuthFormFieldValidatedSuccessEvent',
      build: () => AuthenticationFormFieldBloc(),
      act: (bloc) => bloc.add(const SetAuthFormFieldValidatedSuccessEvent(
          visibleInputContent: true)),
      expect: () => [
        const AuthFormFieldSuccessState(isVisibleContent: true),
      ],
    );

    blocTest<AuthenticationFormFieldBloc, AuthenticationFormFieldState>(
      'não emite [AuthFormFieldSuccessState] se o estado atual for AuthFormFieldErrorState',
      build: () => AuthenticationFormFieldBloc(),
      act: (bloc) {
        bloc.add(const SetAuthFormFieldValidatedSuccessEvent(
            visibleInputContent: true));
        bloc.add(const SetAuthFormFieldValidatedSuccessEvent(
            visibleInputContent: true));
      },
      expect: () => [const AuthFormFieldSuccessState(isVisibleContent: true)],
    );

    blocTest<AuthenticationFormFieldBloc, AuthenticationFormFieldState>(
      'alterna o estado corretamente com ToggleAuthFormFieldVisibilityEvent a partir do AuthFormFieldInitialState',
      build: () => AuthenticationFormFieldBloc(isVisibleContent: true),
      act: (bloc) => bloc.add(
          const ToggleAuthFormFieldVisibilityEvent(visibleInputContent: false)),
      expect: () => [
        const AuthFormFieldInitialState(isVisibleContent: false),
      ],
    );

    blocTest<AuthenticationFormFieldBloc, AuthenticationFormFieldState>(
      'alterna o estado corretamente com ToggleAuthFormFieldVisibilityEvent a partir do AuthFormFieldSuccessState',
      build: () => AuthenticationFormFieldBloc(isVisibleContent: true),
      act: (bloc) {
        bloc.add(const SetAuthFormFieldValidatedSuccessEvent(
            visibleInputContent: true));
        bloc.add(const ToggleAuthFormFieldVisibilityEvent(
            visibleInputContent: false));
      },
      expect: () => [
        const AuthFormFieldSuccessState(isVisibleContent: true),
        const AuthFormFieldSuccessState(isVisibleContent: false),
      ],
    );

    blocTest<AuthenticationFormFieldBloc, AuthenticationFormFieldState>(
      'alterna o estado corretamente com ToggleAuthFormFieldVisibilityEvent a partir do AuthFormFieldErrorState',
      build: () => AuthenticationFormFieldBloc(isVisibleContent: true),
      act: (bloc) {
        bloc.add(const SetAuthFormFieldValidatedErrorEvent(
            visibleInputContent: true));
        bloc.add(const ToggleAuthFormFieldVisibilityEvent(
            visibleInputContent: false));
      },
      expect: () => [
        const AuthFormFieldErrorState(isVisibleContent: true),
        const AuthFormFieldErrorState(isVisibleContent: false),
      ],
    );
  });
}
