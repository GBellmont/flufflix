import 'package:flutter/material.dart';

class StyleProps {
  ButtonStyle buttonStyle;
  TextStyle textStyle;

  StyleProps({required this.buttonStyle, required this.textStyle});
}

class StyledButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final bool primary;
  final bool isLoading;
  final bool isError;

  const StyledButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.primary = true,
      this.isLoading = false,
      this.isError = false});

  StyleProps getPrymaryStyle() {
    final buttonStyleColor = isError ? Colors.red : const Color(0xff32A873);

    return StyleProps(
        buttonStyle: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4))),
          shadowColor: buttonStyleColor,
          elevation: 5,
          backgroundColor: buttonStyleColor,
        ),
        textStyle: TextStyle(
          color: isError ? Colors.white : const Color(0xff121212),
          fontWeight: FontWeight.w900,
          fontSize: 14,
        ));
  }

  StyleProps getSecondaryStyle() {
    return StyleProps(
        buttonStyle: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              side: BorderSide(
                  color: isError ? Colors.red : const Color(0xff32A873))),
          backgroundColor: Colors.transparent,
        ),
        textStyle: TextStyle(
          color: isError ? Colors.red : const Color(0xff32A873),
          fontWeight: FontWeight.w900,
          fontSize: 14,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final style = primary ? getPrymaryStyle() : getSecondaryStyle();
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height * 0.06,
      child: AbsorbPointer(
        absorbing: isLoading,
        child: ElevatedButton(
          onPressed: onPressed,
          style: style.buttonStyle,
          child: isLoading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(primary
                        ? const Color(0xff121212)
                        : const Color(0xff32A873)),
                  ),
                )
              : Text(
                  text,
                  style: style.textStyle,
                ),
        ),
      ),
    );
  }
}
