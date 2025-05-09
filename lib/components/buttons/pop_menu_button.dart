import 'package:flutter/material.dart';

class MenuOption {
  final String value;
  final String text;
  final Future<void> Function() action;

  MenuOption({required this.value, required this.text, required this.action});
}

class PopMenuButton extends StatelessWidget {
  final List<MenuOption> options;

  const PopMenuButton({super.key, required this.options});

  void selectAndExecuteAction(String value) async {
    final valueOption = options.firstWhere((option) => option.value == value);

    await valueOption.action();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      onSelected: selectAndExecuteAction,
      itemBuilder: (context) {
        return options
            .map((element) => PopupMenuItem(
                  value: element.value,
                  child: Text(
                    element.text,
                    style: const TextStyle(color: Colors.white),
                  ),
                ))
            .toList();
      },
    );
  }
}
