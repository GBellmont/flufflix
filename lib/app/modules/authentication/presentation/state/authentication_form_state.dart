import 'package:equatable/equatable.dart';

sealed class AuthenticationFormState extends Equatable {
  const AuthenticationFormState();

  @override
  List<Object> get props => [];
}

class AuthenticationFormStateInitial extends AuthenticationFormState {}

class AuthenticationFormStateLoading extends AuthenticationFormState {}

class AuthenticationFormStateError extends AuthenticationFormState {
  final String errorMessage;

  const AuthenticationFormStateError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class AuthenticationFormStateLoginSucceeded extends AuthenticationFormState {}

class AuthenticationFormStateSignUpSucceeded extends AuthenticationFormState {}
