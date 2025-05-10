import 'package:flufflix/app/core/config/configs.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  tearDown(() async {
    AppConfig.reset();
  });

  group('AppConfigTest', () {
    test('deve criar uma instancia corretamente quando a mesma não existir',
        () async {
      final appConfig = AppConfig.instance;

      expect(appConfig.apiKey, '');
      expect(appConfig.baseImagesUrl, '');
      expect(appConfig.baseUrl, '');
    });
  });
}
