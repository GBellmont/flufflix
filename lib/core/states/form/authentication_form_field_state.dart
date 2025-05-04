sealed class AuthenticationFormFieldState {
  final bool isVisibleContent;

  const AuthenticationFormFieldState({this.isVisibleContent = true});
}

class AuthFormFieldInitialState extends AuthenticationFormFieldState {
  const AuthFormFieldInitialState({super.isVisibleContent});
}

class AuthFormFieldErrorState extends AuthenticationFormFieldState {
  const AuthFormFieldErrorState({super.isVisibleContent});
}

class AuthFormFieldSuccessState extends AuthenticationFormFieldState {
  const AuthFormFieldSuccessState({super.isVisibleContent});
}
