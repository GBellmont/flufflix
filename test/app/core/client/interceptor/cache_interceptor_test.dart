import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flufflix/app/core/client/interceptor/interceptors.dart';

import '../../../../mock/mocks.dart';

const testPath = '/fake';
const baseUrl = 'https://example.com';
const testKey = 'HTTP_CACHE_${testPath}_1';
const testKeyWithOutPage = 'HTTP_CACHE_$testPath';
const sixTenMinutesInMiliSeconds = 16 * 60 * 1000;

void main() {
  late Dio dio;
  late MockSharedPreferences mockPrefs;

  setUpAll(() {
    registerFallbackValue(MockRequestOptions());
  });

  setUp(() {
    mockPrefs = MockSharedPreferences();

    dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..interceptors.add(CacheInterceptor(cacheManager: mockPrefs));
  });

  group('CacheInterceptorTest', () {
    test('deve retornar o cache quando houver o mesmo e não tiver expirado',
        () async {
      final cachedData = {
        'data': {'msg': 'from cache'},
        'expiry': DateTime.now()
            .add(const Duration(minutes: 5))
            .millisecondsSinceEpoch,
      };

      when(() => mockPrefs.getString(testKey))
          .thenReturn(jsonEncode(cachedData));

      final response = await dio.get(testPath, queryParameters: {'page': '1'});

      verify(() => mockPrefs.getString(testKey)).called(1);
      verifyNever(() => mockPrefs.remove(testKey));
      verifyNever(() => mockPrefs.setString(testKey, any<String>()));

      expect(response.data, {'msg': 'from cache'});
      expect(response.statusCode, 200);
    });

    test(
        'deve realizar a chamada http quando o cache for expirado, e salvar cache sem page',
        () async {
      final expiredData = {
        'data': {'msg': 'old'},
        'expiry': DateTime.now()
            .subtract(const Duration(seconds: 1))
            .millisecondsSinceEpoch,
      };

      dio.httpClientAdapter = MockHttpClientAdapter();
      when(() => mockPrefs.getString(testKeyWithOutPage))
          .thenReturn(jsonEncode(expiredData));
      when(() => mockPrefs.remove(testKeyWithOutPage))
          .thenAnswer((_) async => true);
      when(() => mockPrefs.setString(testKeyWithOutPage, any()))
          .thenAnswer((_) async => true);

      when(() => dio.httpClientAdapter.fetch(any(), any(), any()))
          .thenAnswer((_) async => ResponseBody.fromString(
                jsonEncode({'msg': 'fresh'}),
                200,
                headers: {
                  Headers.contentTypeHeader: [Headers.jsonContentType]
                },
              ));

      final response = await dio.get(testPath);

      verify(() => mockPrefs.getString(testKeyWithOutPage)).called(1);
      verify(() => mockPrefs.remove(testKeyWithOutPage)).called(1);
      final setStringContentCaptured = verify(() =>
              mockPrefs.setString(testKeyWithOutPage, captureAny<String>()))
          .captured;

      final cacheBody = jsonDecode(setStringContentCaptured[0] as String);
      final expiry = cacheBody['expiry'] as int;
      final now = DateTime.now().millisecondsSinceEpoch;

      expect(response.data, {'msg': 'fresh'});
      expect(cacheBody['data'], {'msg': 'fresh'});
      expect(expiry, greaterThan(now));
      expect(expiry, lessThan(now + sixTenMinutesInMiliSeconds));
    });

    test(
        'deve realizar a chamada http quando não houver cache, e registrar a sua response',
        () async {
      final expectedStringResponseBody = jsonEncode({'msg': 'fresh'});

      final fakeResponse = ResponseBody.fromString(
        expectedStringResponseBody,
        200,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType]
        },
      );

      dio.httpClientAdapter = MockHttpClientAdapter();
      when(() => mockPrefs.getString(testKey)).thenReturn(null);
      when(() => mockPrefs.setString(testKey, any<String>()))
          .thenAnswer((_) async => true);

      when(() => dio.httpClientAdapter.fetch(any(), any(), any()))
          .thenAnswer((_) async => fakeResponse);

      final response = await dio.get(testPath, queryParameters: {'page': '1'});

      verify(() => mockPrefs.getString(testKey)).called(1);
      final setStringContentCaptured =
          verify(() => mockPrefs.setString(testKey, captureAny<String>()))
              .captured;
      verifyNever(() => mockPrefs.remove(testKey));

      final cacheBody = jsonDecode(setStringContentCaptured[0] as String);
      final expiry = cacheBody['expiry'] as int;
      final now = DateTime.now().millisecondsSinceEpoch;

      expect(response.data, {'msg': 'fresh'});
      expect(cacheBody['data'], {'msg': 'fresh'});
      expect(expiry, greaterThan(now));
      expect(expiry, lessThan(now + sixTenMinutesInMiliSeconds));
    });
  });
}
