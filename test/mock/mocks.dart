import 'package:dio/dio.dart';
import 'package:flufflix/app/core/client/clients.dart';
import 'package:flufflix/app/modules/content/data/external/externals.dart';
import 'package:flufflix/app/modules/content/data/repository/repositories.dart';
import 'package:flufflix/app/modules/shared/data/external/externals.dart';
import 'package:flufflix/app/modules/shared/data/model/models.dart';
import 'package:flufflix/app/modules/shared/data/repository/repositories.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flufflix/app/core/client/interceptor/interceptors.dart';

class MockHttpClientAdapter extends Mock implements HttpClientAdapter {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockRequestOptions extends Fake implements RequestOptions {}

class MockCacheInterceptor extends Mock implements CacheInterceptor {}

class MockHttpClient extends Mock implements HttpClient {}

class MockMovieApi extends Mock implements MovieApi {}

class MockSerieApi extends Mock implements SerieApi {}

class MockPersistentContentDataSource extends Mock
    implements PersistentContentDataSource {}

class MockMovieRepositoryImpl extends Mock implements MovieRepositoryImpl {}

class MockSerieRepositoryImpl extends Mock implements SerieRepositoryImpl {}

class MockPersistentContentRepositoryImpl extends Mock
    implements PersistentContentRepositoryImpl {}

class PersistentContentModelFake extends Fake
    implements PersistentContentModel {}
