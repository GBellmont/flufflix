import 'dart:developer';
import 'package:flutter/foundation.dart';

class AppError implements Exception {
  final String? message;
  final StackTrace stackTrace;
  final Object? error;

  AppError({this.message, required this.stackTrace, this.error}) {
    if (kDebugMode) {
      log("StackTrace: $stackTrace || Error: $error");
    }
  }
}

class SerializerError extends AppError {
  SerializerError(
      {required super.stackTrace, super.message, required super.error});
}

class PersistentError extends AppError {
  PersistentError(
      {required super.stackTrace, super.message, required super.error});
}

class NetworkError extends AppError {
  NetworkError({required super.stackTrace, super.message, super.error});
}
