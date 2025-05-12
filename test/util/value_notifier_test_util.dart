import 'package:flutter/material.dart';

class ValueNotifierTest<T> {
  final ValueNotifier<T> notifier;
  List<T> _emitedValues = [];

  ValueNotifierTest({required this.notifier});

  void enableListener() {
    notifier.addListener(_emittedCouterListener);
  }

  void disposeListener() {
    notifier.removeListener(_emittedCouterListener);
  }

  List<T> get emitedValues => _emitedValues;

  void resetEmittedValues() {
    _emitedValues = [];
  }

  void _emittedCouterListener() {
    _emitedValues.add(notifier.value);
  }
}
