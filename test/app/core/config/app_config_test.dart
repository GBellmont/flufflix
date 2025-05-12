import 'package:flutter_test/flutter_test.dart';

import 'package:flufflix/app/core/config/configs.dart';

void main() {
  tearDown(() async {
    AppConfig.reset();
  });

  group('AppConfigTest', () {
    group('Intance Test', () {
      test('deve criar uma instancia corretamente quando a mesma não existir',
          () async {
        final appConfig = AppConfig.instance;

        expect(appConfig.apiKey, '');
        expect(appConfig.baseImagesUrl, '');
        expect(appConfig.baseUrl, '');
      });
    });
  });
}
