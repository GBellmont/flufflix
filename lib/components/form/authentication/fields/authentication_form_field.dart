import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flufflix/core/blocs/index.dart';
import 'package:flufflix/core/events/index.dart';
import 'package:flufflix/core/states/index.dart';

class AuthenticationFormField extends StatefulWidget {
  final IconData icon;
  final String labelText;
  final String? Function(String? value) validator;
  final TextInputType keyboardType;
  final bool isPasswordInput;
  final TextEditingController controller;

  const AuthenticationFormField(
      {super.key,
      required this.icon,
      required this.labelText,
      required this.validator,
      this.keyboardType = TextInputType.text,
      this.isPasswordInput = false,
      required this.controller});

  @override
  State<StatefulWidget> createState() => _AuthenticationFormFieldState();
}

class _AuthenticationFormFieldState extends State<AuthenticationFormField> {
  late final AuthenticationFormFieldBloc _authenticationFormFieldBloc;

  @override
  void initState() {
    _authenticationFormFieldBloc =
        AuthenticationFormFieldBloc(isVisibleContent: !widget.isPasswordInput);

    super.initState();
  }

  @override
  void dispose() {
    _authenticationFormFieldBloc.close();
    super.dispose();
  }

  String? validateAndSetInputState(String? value) {
    final validationResult = widget.validator(value);

    if (validationResult != null) {
      _authenticationFormFieldBloc.add(SetAuthFormFieldValidatedErrorEvent(
          visibleInputContent:
              _authenticationFormFieldBloc.state.isVisibleContent));
      return validationResult;
    }

    _authenticationFormFieldBloc.add(SetAuthFormFieldValidatedSuccessEvent(
        visibleInputContent:
            _authenticationFormFieldBloc.state.isVisibleContent));
    return null;
  }

  void setContentVisibility(bool newValue) {
    _authenticationFormFieldBloc
        .add(ToggleAuthFormFieldVisibilityEvent(visibleInputContent: newValue));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationFormFieldBloc,
            AuthenticationFormFieldState>(
        bloc: _authenticationFormFieldBloc,
        builder: (context, state) {
          switch (state) {
            case AuthFormFieldInitialState():
              return _ColoredAuthFormField(
                controller: widget.controller,
                color: Colors.grey,
                icon: widget.icon,
                isInactive: true,
                labelText: widget.labelText,
                keyboardType: widget.keyboardType,
                validator: validateAndSetInputState,
                toggleContentVisibility: setContentVisibility,
                isPasswordInput: widget.isPasswordInput,
                isVisibleContent: state.isVisibleContent,
              );
            case AuthFormFieldErrorState():
              return _ColoredAuthFormField(
                  controller: widget.controller,
                  color: Colors.red,
                  icon: widget.icon,
                  isInactive: false,
                  labelText: widget.labelText,
                  keyboardType: widget.keyboardType,
                  isPasswordInput: widget.isPasswordInput,
                  validator: validateAndSetInputState,
                  toggleContentVisibility: setContentVisibility,
                  isVisibleContent: state.isVisibleContent);
            case AuthFormFieldSuccessState():
              return _ColoredAuthFormField(
                  controller: widget.controller,
                  color: const Color(0xff32A873),
                  icon: widget.icon,
                  isInactive: false,
                  labelText: widget.labelText,
                  keyboardType: widget.keyboardType,
                  validator: validateAndSetInputState,
                  toggleContentVisibility: setContentVisibility,
                  isPasswordInput: widget.isPasswordInput,
                  isVisibleContent: state.isVisibleContent);
          }
        });
  }
}

class _ColoredAuthFormField extends StatelessWidget {
  final IconData icon;
  final Color color;
  final bool isInactive;
  final bool isPasswordInput;
  final bool isVisibleContent;
  final String labelText;
  final TextInputType keyboardType;
  final String? Function(String? value) validator;
  final void Function(bool newValue) toggleContentVisibility;
  final TextEditingController controller;

  const _ColoredAuthFormField(
      {required this.color,
      required this.isInactive,
      required this.labelText,
      required this.keyboardType,
      required this.validator,
      required this.icon,
      required this.isPasswordInput,
      required this.isVisibleContent,
      required this.toggleContentVisibility,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: color),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color),
          borderRadius: BorderRadius.circular(4.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color, width: 2.0),
          borderRadius: BorderRadius.circular(4.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color),
          borderRadius: BorderRadius.circular(4.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color, width: 2.0),
          borderRadius: BorderRadius.circular(4.0),
        ),
        labelText: labelText,
        labelStyle: TextStyle(color: color),
        helperText: isInactive ? 'Inactive' : '',
        prefixIcon: Icon(
          icon,
          color: color,
        ),
        suffixIcon: isPasswordInput
            ? IconButton(
                icon: Icon(
                  isVisibleContent ? Icons.visibility_off : Icons.visibility,
                ),
                color: color,
                onPressed: () => toggleContentVisibility(!isVisibleContent),
              )
            : null,
      ),
      autovalidateMode: AutovalidateMode.onUnfocus,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: !isVisibleContent,
    );
  }
}
