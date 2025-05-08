sealed class AuthenticationFormFieldEvent {
  final bool visibleInputContent;

  const AuthenticationFormFieldEvent({this.visibleInputContent = true});
}

class SetAuthFormFieldValidatedErrorEvent extends AuthenticationFormFieldEvent {
  const SetAuthFormFieldValidatedErrorEvent({super.visibleInputContent});
}

class SetAuthFormFieldValidatedSuccessEvent
    extends AuthenticationFormFieldEvent {
  const SetAuthFormFieldValidatedSuccessEvent({super.visibleInputContent});
}

class ToggleAuthFormFieldVisibilityEvent extends AuthenticationFormFieldEvent {
  const ToggleAuthFormFieldVisibilityEvent({super.visibleInputContent});
}
