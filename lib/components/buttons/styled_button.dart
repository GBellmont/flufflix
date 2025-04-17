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

  const StyledButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.primary = true});

  StyleProps getPrymaryStyle() {
    return StyleProps(
        buttonStyle: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4))),
          backgroundColor: const Color(0xff32A873),
        ),
        textStyle: const TextStyle(
          color: Color(0xff121212),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ));
  }

  StyleProps getSecondaryStyle() {
    return StyleProps(
        buttonStyle: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              side: BorderSide(color: Color(0xff32A873))),
          backgroundColor: Colors.transparent,
        ),
        textStyle: const TextStyle(
          color: Color(0xff32A873),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final style = primary ? getPrymaryStyle() : getSecondaryStyle();
    final size = MediaQuery.of(context).size;

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: size.width,
          height: size.height * 0.06,
          child: ElevatedButton(
            onPressed: onPressed,
            style: style.buttonStyle,
            child: Text(
              text,
              style: style.textStyle,
            ),
          ),
        ));
  }
}
