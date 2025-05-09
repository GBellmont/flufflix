sealed class AuthenticationFormState {
  const AuthenticationFormState();
}

class AuthenticationFormStateInitial extends AuthenticationFormState {}

class AuthenticationFormStateLoading extends AuthenticationFormState {}

class AuthenticationFormStateError extends AuthenticationFormState {
  final String errorMessage;

  const AuthenticationFormStateError({required this.errorMessage});
}

class AuthenticationFormStateLoginSucceeded extends AuthenticationFormState {}

class AuthenticationFormStateSignUpSucceeded extends AuthenticationFormState {}
