import 'package:dio/io.dart';

import 'package:flufflix/app/core/client/interceptors/interceptors.dart';
import 'package:flufflix/app/core/config/configs.dart';

class HttpClient extends DioForNative {
  HttpClient() {
    options.baseUrl = AppConfig.instance.baseUrl;
    interceptors.addAll([CacheInterceptor(), AuthInterceptor()]);
  }
}
