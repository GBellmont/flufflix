import 'package:flutter/material.dart';

enum StyledSnackBarType {
  success(typeColor: Color(0xff32A873)),
  error(typeColor: Colors.red),
  alert(typeColor: Colors.orangeAccent);

  final Color typeColor;

  const StyledSnackBarType({required this.typeColor});
}

class StyledSnackBar extends SnackBar {
  StyledSnackBar({
    super.key,
    required String text,
    required StyledSnackBarType type,
  }) : super(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 3),
          closeIconColor: type.typeColor,
          showCloseIcon: true,
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            side: BorderSide(color: type.typeColor),
          ),
          content: Text(
            text,
            style: TextStyle(color: type.typeColor),
          ),
        );
}
