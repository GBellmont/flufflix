import 'package:flutter/material.dart';

final class AppConfig {
  static AppConfig? _instance;

  final String apiKey;
  final String baseImagesUrl;
  final String baseUrl;

  @visibleForTesting
  const AppConfig(
      {this.apiKey = '', this.baseImagesUrl = '', this.baseUrl = ''});

  AppConfig._internal(
      {required this.apiKey,
      required this.baseImagesUrl,
      required this.baseUrl});

  static AppConfig get instance {
    if (_instance != null) {
      return _instance!;
    }

    _instance = AppConfig._internal(
        apiKey: const String.fromEnvironment("API_KEY"),
        baseImagesUrl: const String.fromEnvironment("BASE_IMAGES_URL"),
        baseUrl: const String.fromEnvironment("BASE_URL"));

    return _instance!;
  }

  @visibleForTesting
  static void overrideForTest(AppConfig config) {
    _instance = config;
  }

  @visibleForTesting
  static void reset() {
    _instance = null;
  }
}
