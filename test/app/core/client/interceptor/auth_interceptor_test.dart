import 'package:dio/dio.dart';
import 'package:flufflix/app/core/config/configs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flufflix/app/core/client/interceptor/interceptors.dart';

import '../../../../mock/mocks.dart';

const String fakeApiKey = 'MINHA_API_KEY';

void main() {
  late final MockHttpClientAdapter mockHttpClientAdapter;
  late final Dio dio;

  setUp(() async {
    mockHttpClientAdapter = MockHttpClientAdapter();
    dio = Dio()
      ..httpClientAdapter = mockHttpClientAdapter
      ..interceptors.add(AuthInterceptor());

    AppConfig.overrideForTest(const AppConfig(apiKey: fakeApiKey));
    registerFallbackValue(RequestOptions(path: ''));
  });

  tearDown(() async {
    AppConfig.reset();
  });

  group('AuthInterceptorTest', () {
    test('Adiciona Authorization e parâmetro corretamente na request',
        () async {
      when(() => mockHttpClientAdapter.fetch(
            any(),
            any(),
            any(),
          )).thenAnswer((invocation) async {
        final request = invocation.positionalArguments[0] as RequestOptions;
        expect(request.headers['Authorization'], equals('Bearer $fakeApiKey'));
        expect(request.queryParameters['language'], equals('pt-BR'));

        return ResponseBody.fromString(
          '{ "message": "ok" }',
          200,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      });

      await dio.get('https://flufflix.com/test');
    });
  });
}
