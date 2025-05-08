import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flufflix/core/states/index.dart';
import 'package:flufflix/core/events/index.dart';

class AuthenticationFormFieldBloc<T>
    extends Bloc<AuthenticationFormFieldEvent, AuthenticationFormFieldState> {
  final bool isVisibleContent;

  AuthenticationFormFieldBloc({this.isVisibleContent = true})
      : super(AuthFormFieldInitialState(isVisibleContent: isVisibleContent)) {
    on<SetAuthFormFieldValidatedErrorEvent>(_setErrorState);
    on<SetAuthFormFieldValidatedSuccessEvent>(_setSuccessState);
    on<ToggleAuthFormFieldVisibilityEvent>(_toggleVisbleInputContent);
  }

  void _setErrorState(SetAuthFormFieldValidatedErrorEvent event, Emitter emit) {
    if (state is! AuthFormFieldErrorState) {
      emit(
          AuthFormFieldErrorState(isVisibleContent: event.visibleInputContent));
    }
  }

  void _setSuccessState(
      SetAuthFormFieldValidatedSuccessEvent event, Emitter emit) {
    if (state is! AuthFormFieldSuccessState) {
      emit(AuthFormFieldSuccessState(
          isVisibleContent: event.visibleInputContent));
    }
  }

  void _toggleVisbleInputContent(
      ToggleAuthFormFieldVisibilityEvent event, Emitter emit) {
    switch (state) {
      case AuthFormFieldInitialState():
        emit(AuthFormFieldInitialState(
            isVisibleContent: event.visibleInputContent));
        break;
      case AuthFormFieldErrorState():
        emit(AuthFormFieldErrorState(
            isVisibleContent: event.visibleInputContent));
        break;
      case AuthFormFieldSuccessState():
        emit(AuthFormFieldSuccessState(
            isVisibleContent: event.visibleInputContent));
        break;
    }
  }
}
