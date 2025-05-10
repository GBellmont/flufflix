import 'package:dio/io.dart';

import 'package:flufflix/app/core/client/interceptor/interceptors.dart';
import 'package:flufflix/app/core/config/configs.dart';
import 'package:flufflix/app/core/injection/injections.dart';

class HttpClient extends DioForNative {
  HttpClient() {
    options.baseUrl = AppConfig.instance.baseUrl;
    interceptors.addAll([getIt.get<CacheInterceptor>(), AuthInterceptor()]);
  }
}
