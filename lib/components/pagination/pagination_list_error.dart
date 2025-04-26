import 'package:flutter/material.dart';

class PaginationListError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const PaginationListError(
      {this.message = 'Error loading content',
      required this.onRetry,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.redAccent,
              size: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: Text(
                message,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      side: BorderSide(color: Colors.white)),
                  backgroundColor: Colors.grey.shade800,
                ),
                child: const Text(
                  'Retry',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ))
          ],
        ),
      ),
    );
  }
}
