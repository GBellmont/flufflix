import 'package:get_it/get_it.dart';

import 'package:flufflix/app/core/client/clients.dart';

import 'package:flufflix/app/modules/authentication/presentation/bloc/blocs.dart';
import 'package:flufflix/app/modules/movie/data/external/externals.dart';
import 'package:flufflix/app/modules/movie/data/repositories/repositories.dart';
import 'package:flufflix/app/modules/movie/presentation/bloc/blocs.dart';

final getIt = GetIt.instance;

void setupGeneralInjection() {
  registerProviders();
  registerExternals();
  registerRepositories();
  registerBlocs();
}

void registerProviders() {
  getIt.registerLazySingleton<HttpClient>(() => HttpClient());
}

void registerExternals() {
  getIt.registerLazySingleton<MovieApi>(
      () => MovieApi(client: getIt.get<HttpClient>()));
}

void registerRepositories() {
  getIt.registerLazySingleton<MovieRepositoryImpl>(
      () => MovieRepositoryImpl(movieApi: getIt.get<MovieApi>()));
}

void registerBlocs() {
  getIt.registerFactory<PaginationBloc>(() =>
      PaginationBloc(movieRepositoryImpl: getIt.get<MovieRepositoryImpl>()));
  getIt.registerFactory<ContentListBloc>(() =>
      ContentListBloc(movieRepositoryImpl: getIt.get<MovieRepositoryImpl>()));
  getIt.registerFactory<ContentDetailsBloc>(() => ContentDetailsBloc(
      movieRepositoryImpl: getIt.get<MovieRepositoryImpl>()));

  getIt.registerFactory<AuthenticationFormBloc>(() => AuthenticationFormBloc());
  getIt.registerFactoryParam<AuthenticationFormFieldBloc, bool, dynamic>(
      (isVisibleContent, _) =>
          AuthenticationFormFieldBloc(isVisibleContent: isVisibleContent));
}
