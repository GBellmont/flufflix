sealed class AuthenticationFormEvent {
  final String email;
  final String password;

  const AuthenticationFormEvent({required this.email, required this.password});
}

class PerformLoginAuthenticationEvent extends AuthenticationFormEvent {
  const PerformLoginAuthenticationEvent(
      {required super.email, required super.password});
}

class PerformSignedUpAuthenticationEvent extends AuthenticationFormEvent {
  final String username;

  const PerformSignedUpAuthenticationEvent(
      {required super.email, required super.password, required this.username});
}
