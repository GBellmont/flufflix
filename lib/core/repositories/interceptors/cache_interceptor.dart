import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheInterceptor extends Interceptor {
  final String baseCacheKey;

  CacheInterceptor({required this.baseCacheKey});

  SharedPreferences? _preferences;
  FutureOr<SharedPreferences> get cacheProvider async {
    _preferences ??= await SharedPreferences.getInstance();
    return _preferences!;
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final path = options.uri.path;
    final page = options.uri.queryParameters['page'] ?? '1';

    final cacheManager = await cacheProvider;
    final cachedData = cacheManager.getString(_generateCacheKey(path, page));

    if (cachedData != null) {
      return handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 200,
          data: jsonDecode(cachedData),
        ),
      );
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    final path = response.requestOptions.uri.path;
    final page = response.requestOptions.uri.queryParameters['page'] ?? '1';

    final cacheManager = await cacheProvider;
    cacheManager.setString(
        _generateCacheKey(path, page), jsonEncode(response.data));

    return handler.next(response);
  }

  String _generateCacheKey(String path, String page) {
    return "${baseCacheKey}_${path}_$page";
  }
}
