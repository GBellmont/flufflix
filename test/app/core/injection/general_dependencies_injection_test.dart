import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flufflix/app/core/client/clients.dart';
import 'package:flufflix/app/core/client/interceptor/interceptors.dart';
import 'package:flufflix/app/core/injection/injections.dart';
import 'package:flufflix/app/modules/authentication/presentation/bloc/blocs.dart';
import 'package:flufflix/app/modules/movie/data/external/externals.dart';
import 'package:flufflix/app/modules/movie/data/repository/repositories.dart';
import 'package:flufflix/app/modules/movie/presentation/bloc/blocs.dart';

import '../../../mock/mocks.dart';

void main() {
  tearDown(() async {
    getIt.reset();
  });

  group('GeneralDependenciesInjectionTest', () {
    test('deve registrar as dependências corretamente', () async {
      final mockPrefs = MockSharedPreferences();
      setupGeneralInjection(prefs: mockPrefs);

      verifyIfIsRegistered();
      verifySingletonsSameInstance(prefs: mockPrefs);
      verifyDependencies();
      verifyParams();
    });
  });
}

void verifyIfIsRegistered() {
  expect(getIt.isRegistered<SharedPreferences>(), isTrue);
  expect(getIt.isRegistered<CacheInterceptor>(), isTrue);
  expect(getIt.isRegistered<HttpClient>(), isTrue);
  expect(getIt.isRegistered<MovieApi>(), isTrue);
  expect(getIt.isRegistered<MovieRepositoryImpl>(), isTrue);
  expect(getIt.isRegistered<PaginationBloc>(), isTrue);
  expect(getIt.isRegistered<ContentListBloc>(), isTrue);
  expect(getIt.isRegistered<ContentDetailsBloc>(), isTrue);
  expect(getIt.isRegistered<AuthenticationFormBloc>(), isTrue);
  expect(getIt.isRegistered<AuthenticationFormFieldBloc>(), isTrue);
}

void verifySingletonsSameInstance({required SharedPreferences prefs}) {
  final prefsGet = getIt.get<SharedPreferences>();
  final anotherPrefsGet = getIt.get<SharedPreferences>();

  final interceptor = getIt.get<CacheInterceptor>();
  final anotherInterceptor = getIt.get<CacheInterceptor>();

  final client = getIt.get<HttpClient>();
  final anotherClient = getIt.get<HttpClient>();

  final movieApi = getIt.get<MovieApi>();
  final anotherMovieApi = getIt.get<MovieApi>();

  final movieRepositoryImpl = getIt.get<SharedPreferences>();
  final anotherMovieRepositoryImpl = getIt.get<SharedPreferences>();

  expect(identical(prefs, prefsGet), isTrue);
  expect(identical(prefsGet, anotherPrefsGet), isTrue);
  expect(identical(interceptor, anotherInterceptor), isTrue);
  expect(identical(client, anotherClient), isTrue);
  expect(identical(movieApi, anotherMovieApi), isTrue);
  expect(identical(movieRepositoryImpl, anotherMovieRepositoryImpl), isTrue);
}

void verifyDependencies() {
  final movieApi = getIt.get<MovieApi>();

  final movieRepositoryImpl = getIt.get<MovieRepositoryImpl>();

  final paginationBloc = getIt.get<PaginationBloc>();
  final contentListBloc = getIt.get<ContentListBloc>();
  final contentDetailsBloc = getIt.get<ContentDetailsBloc>();

  expect(identical(movieRepositoryImpl.movieApi, movieApi), isTrue);
  expect(identical(paginationBloc.movieRepositoryImpl, movieRepositoryImpl),
      isTrue);
  expect(identical(contentListBloc.movieRepositoryImpl, movieRepositoryImpl),
      isTrue);
  expect(identical(contentDetailsBloc.movieRepositoryImpl, movieRepositoryImpl),
      isTrue);
}

void verifyParams() {
  final authenticationFormFieldBloc =
      getIt<AuthenticationFormFieldBloc>(param1: true);

  expect(authenticationFormFieldBloc, isA<AuthenticationFormFieldBloc>());
  expect(authenticationFormFieldBloc.state.isVisibleContent, isTrue);
}
