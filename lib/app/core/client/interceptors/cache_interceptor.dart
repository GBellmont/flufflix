import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheInterceptor extends Interceptor {
  SharedPreferences? _preferences;
  FutureOr<SharedPreferences> get cacheProvider async {
    _preferences ??= await SharedPreferences.getInstance();
    return _preferences!;
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final path = options.uri.path;
    final page = options.uri.queryParameters['page'];
    final cacheManager = await cacheProvider;
    final cacheKey = _generateCacheKey(path, page);

    final cachedRaw = cacheManager.getString(cacheKey);

    if (cachedRaw != null) {
      final cached = jsonDecode(cachedRaw);
      final expiry = cached['expiry'] as int;
      final now = DateTime.now().millisecondsSinceEpoch;

      if (now < expiry) {
        return handler.resolve(
          Response(
            requestOptions: options,
            statusCode: 200,
            data: cached['data'],
          ),
        );
      } else {
        cacheManager.remove(cacheKey);
      }
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    final path = response.requestOptions.uri.path;
    final page = response.requestOptions.uri.queryParameters['page'] ?? '1';
    final cacheManager = await cacheProvider;

    final cacheKey = _generateCacheKey(path, page);
    const ttl = Duration(minutes: 15);

    final cachedEntry = {
      'data': response.data,
      'expiry': DateTime.now().add(ttl).millisecondsSinceEpoch,
    };

    cacheManager.setString(cacheKey, jsonEncode(cachedEntry));
    return handler.next(response);
  }

  String _generateCacheKey(String path, String? page) {
    return page != null ? "HTTP_CACHE_${path}_$page" : "HTTP_CACHE_$path";
  }
}
