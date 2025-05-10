import 'package:flutter_test/flutter_test.dart';

import 'package:flufflix/app/core/config/configs.dart';
import 'package:flufflix/app/core/injection/injections.dart';
import 'package:flufflix/app/core/client/clients.dart';
import 'package:flufflix/app/core/client/interceptor/interceptors.dart';

import '../../../mock/mocks.dart';

const fakeBaseUrl = 'https://api.example.com';

void main() {
  late MockCacheInterceptor mockCacheInterceptor;

  setUp(() {
    mockCacheInterceptor = MockCacheInterceptor();
    getIt.registerSingleton<CacheInterceptor>(mockCacheInterceptor);
    AppConfig.overrideForTest(const AppConfig(baseUrl: fakeBaseUrl));
  });

  tearDown(() {
    getIt.reset();
  });

  group('HttpClientTest', () {
    test('deve configurar corretamente o HttpClient com interceptors e baseUrl',
        () {
      final client = HttpClient();

      expect(client.options.baseUrl, fakeBaseUrl);

      final hasCacheInterceptor =
          client.interceptors.any((i) => i == mockCacheInterceptor);
      final hasAuthInterceptor =
          client.interceptors.any((i) => i.runtimeType == AuthInterceptor);

      expect(hasCacheInterceptor, isTrue);
      expect(hasAuthInterceptor, isTrue);
    });
  });
}
