import 'package:dio/dio.dart';
import 'package:flufflix/app/core/client/clients.dart';
import 'package:flufflix/app/modules/movie/data/external/externals.dart';
import 'package:flufflix/app/modules/movie/data/repository/repositories.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flufflix/app/core/client/interceptor/interceptors.dart';

class MockHttpClientAdapter extends Mock implements HttpClientAdapter {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockRequestOptions extends Fake implements RequestOptions {}

class MockCacheInterceptor extends Mock implements CacheInterceptor {}

class MockHttpClient extends Mock implements HttpClient {}

class MockMovieApi extends Mock implements MovieApi {}

class MockMovieRepositoryImpl extends Mock implements MovieRepositoryImpl {}
