import 'package:dio/dio.dart';

import 'package:flufflix/app/core/config/configs.dart';
import 'package:flufflix/app/core/constants/constants.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers
        .addAll({'Authorization': 'Bearer ${AppConfig.instance.apiKey}'});
    options.queryParameters.addAll({
      'language': ContentConstants.defaultPtBrLanguage,
    });

    super.onRequest(options, handler);
  }
}
