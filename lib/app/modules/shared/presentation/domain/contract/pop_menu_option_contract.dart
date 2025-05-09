class PopMenuOptionContract {
  final String value;
  final String text;
  final Future<void> Function() action;

  PopMenuOptionContract(
      {required this.value, required this.text, required this.action});
}
