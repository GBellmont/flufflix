final class EnvConstants {
  static EnvConstants? _instance;

  final String apiKey;
  final String baseImagesUrl;
  final String baseUrl;

  EnvConstants._internal(
      {required this.apiKey,
      required this.baseImagesUrl,
      required this.baseUrl});

  static EnvConstants get instance {
    if (_instance != null) {
      return _instance!;
    }

    _instance = EnvConstants._internal(
        apiKey: const String.fromEnvironment("API_KEY"),
        baseImagesUrl: const String.fromEnvironment("BASE_IMAGES_URL"),
        baseUrl: const String.fromEnvironment("BASE_URL"));

    return _instance!;
  }
}
