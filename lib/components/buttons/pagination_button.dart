import 'package:flutter/material.dart';

class PaginationButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool right;

  const PaginationButton(
      {super.key, required this.onPressed, this.right = false});

  @override
  Widget build(BuildContext context) {
    final icon = right ? Icons.arrow_forward_ios : Icons.arrow_back_ios;

    return Padding(
        padding: EdgeInsets.only(right: right ? 0 : 10),
        child: SizedBox(
          width: 40,
          height: 180,
          child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    side: BorderSide(color: Colors.white)),
                backgroundColor: Colors.grey.shade800,
                elevation: 4,
              ),
              child: Transform.translate(
                offset: Offset(right ? 0 : 4, 0),
                child: Icon(
                  icon,
                  size: 24,
                  color: Colors.white,
                ),
              )),
        ));
  }
}
