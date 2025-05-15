import 'package:flufflix/app/modules/content/presentation/store/stores.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flufflix/app/core/client/clients.dart';
import 'package:flufflix/app/core/client/interceptor/interceptors.dart';

import 'package:flufflix/app/modules/authentication/presentation/bloc/blocs.dart';
import 'package:flufflix/app/modules/content/data/external/externals.dart';
import 'package:flufflix/app/modules/content/data/repository/repositories.dart';
import 'package:flufflix/app/modules/content/presentation/bloc/blocs.dart';
import 'package:flufflix/app/modules/shared/data/external/externals.dart';
import 'package:flufflix/app/modules/shared/data/repository/repositories.dart';
import 'package:flufflix/app/modules/shared/presentation/bloc/blocs.dart';

final getIt = GetIt.instance;

void setupGeneralInjection({required SharedPreferences prefs}) {
  registerProviders(prefs: prefs);
  registerExternals();
  registerRepositories();
  registerBlocs();
  registerStores();
}

void registerProviders({required SharedPreferences prefs}) {
  getIt.registerLazySingleton<SharedPreferences>(() => prefs);
  getIt.registerLazySingleton<CacheInterceptor>(
      () => CacheInterceptor(cacheManager: getIt.get<SharedPreferences>()));
  getIt.registerLazySingleton<HttpClient>(() => HttpClient());
}

void registerExternals() {
  getIt.registerLazySingleton<MovieApi>(
      () => MovieApi(client: getIt.get<HttpClient>()));
  getIt.registerLazySingleton<SerieApi>(
      () => SerieApi(client: getIt.get<HttpClient>()));
  getIt.registerLazySingleton<PersistentContentDataSource>(() =>
      PersistentContentDataSource(
          persistentManager: getIt.get<SharedPreferences>()));
}

void registerRepositories() {
  getIt.registerLazySingleton<MovieRepositoryImpl>(
      () => MovieRepositoryImpl(movieApi: getIt.get<MovieApi>()));
  getIt.registerLazySingleton<SerieRepositoryImpl>(
      () => SerieRepositoryImpl(serieApi: getIt.get<SerieApi>()));
  getIt.registerLazySingleton<PersistentContentRepositoryImpl>(() =>
      PersistentContentRepositoryImpl(
          persistentDataSource: getIt.get<PersistentContentDataSource>()));
}

void registerBlocs() {
  getIt.registerFactory<PaginationBloc>(() => PaginationBloc(
      movieRepositoryImpl: getIt.get<MovieRepositoryImpl>(),
      serieRepositoryImpl: getIt.get<SerieRepositoryImpl>()));
  getIt.registerFactory<ContentListBloc>(() => ContentListBloc(
      movieRepositoryImpl: getIt.get<MovieRepositoryImpl>(),
      serieRepositoryImpl: getIt.get<SerieRepositoryImpl>()));
  getIt.registerFactory<ContentDetailsBloc>(() => ContentDetailsBloc(
      movieRepositoryImpl: getIt.get<MovieRepositoryImpl>(),
      serieRepositoryImpl: getIt.get<SerieRepositoryImpl>()));
  getIt.registerFactory<PopMenuOptionsBloc>(() => PopMenuOptionsBloc(
      persistentContentRepositoryImpl:
          getIt.get<PersistentContentRepositoryImpl>()));

  getIt.registerFactory<AuthenticationFormBloc>(() => AuthenticationFormBloc());
  getIt.registerFactoryParam<AuthenticationFormFieldBloc, bool, dynamic>(
      (isVisibleContent, _) =>
          AuthenticationFormFieldBloc(isVisibleContent: isVisibleContent));
}

void registerStores() {
  getIt.registerFactory<StoredContentStore>(() => StoredContentStore(
      persistentContentRepositoryImpl:
          getIt.get<PersistentContentRepositoryImpl>()));
}
