import 'package:equatable/equatable.dart';

sealed class AuthenticationFormFieldState extends Equatable {
  final bool isVisibleContent;

  const AuthenticationFormFieldState({this.isVisibleContent = true});

  @override
  List<Object> get props => [isVisibleContent];
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
