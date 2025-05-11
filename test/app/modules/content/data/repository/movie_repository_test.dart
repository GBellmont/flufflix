import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flufflix/app/core/error/errors.dart';
import 'package:flufflix/app/core/response/responses.dart';

import 'package:flufflix/app/modules/content/data/external/externals.dart';
import 'package:flufflix/app/modules/content/data/model/models.dart';
import 'package:flufflix/app/modules/content/data/repository/repositories.dart';

import '../../../../../mock/factory/factories.dart';
import '../../../../../mock/mocks.dart';

const String id = '123';
const int page = 123;

void main() {
  late final MovieApi movieApi;
  late final MovieRepositoryImpl movieRepositoryImpl;

  setUpAll(() async {
    movieApi = MockMovieApi();
    movieRepositoryImpl = MovieRepositoryImpl(movieApi: movieApi);
  });

  group('MovieRepositoryImpl', () {
    group('getMovieDetails', () {
      test('deve buscar os detalhes de um filme corretamente', () async {
        when(() => movieApi.getMovieDetails(id))
            .thenAnswer((_) async => MoviesModelFactory.getMovieDetailsModel());

        final response = await movieRepositoryImpl.getMovieDetails(id);

        verify(() => movieApi.getMovieDetails(id)).called(1);

        expect(response, isA<AppResponse>());
        expect(response.hasError, isFalse);
        expect(response.success, isA<MovieDetailsModel>());
        expect(response.error, isNull);
      });

      test('deve retornar response com error caso o mesmo seja um AppError',
          () async {
        when(() => movieApi.getMovieDetails(id))
            .thenThrow(AppError(stackTrace: StackTrace.current));

        final response = await movieRepositoryImpl.getMovieDetails(id);

        verify(() => movieApi.getMovieDetails(id)).called(1);

        expect(response, isA<AppResponse>());
        expect(response.hasError, isTrue);
        expect(response.success, isNull);
        expect(response.error, isA<AppError>());
      });

      test('deve retornar erro caso o mesmo seja genérico', () async {
        when(() => movieApi.getMovieDetails(id)).thenThrow(Exception());

        expect(
          () async => await movieRepositoryImpl.getMovieDetails(id),
          throwsA(isA<Exception>()),
        );

        verify(() => movieApi.getMovieDetails(id)).called(1);
      });
    });

    group('getMovieTrailers', () {
      test('deve buscar os trailers de um filme corretamente', () async {
        when(() => movieApi.getMovieTrailers(id)).thenAnswer(
            (_) async => MoviesModelFactory.getMovieTrailersModel());

        final response = await movieRepositoryImpl.getMovieTrailers(id);

        verify(() => movieApi.getMovieTrailers(id)).called(1);

        expect(response, isA<AppResponse>());
        expect(response.hasError, isFalse);
        expect(response.success, isA<MovieTrailersModel>());
        expect(response.error, isNull);
      });

      test('deve retornar response com error caso o mesmo seja um AppError',
          () async {
        when(() => movieApi.getMovieTrailers(id))
            .thenThrow(AppError(stackTrace: StackTrace.current));

        final response = await movieRepositoryImpl.getMovieTrailers(id);

        verify(() => movieApi.getMovieTrailers(id)).called(1);

        expect(response, isA<AppResponse>());
        expect(response.hasError, isTrue);
        expect(response.success, isNull);
        expect(response.error, isA<AppError>());
      });

      test('deve retornar erro caso o mesmo seja genérico', () async {
        when(() => movieApi.getMovieTrailers(id)).thenThrow(Exception());

        expect(
          () async => await movieRepositoryImpl.getMovieTrailers(id),
          throwsA(isA<Exception>()),
        );

        verify(() => movieApi.getMovieTrailers(id)).called(1);
      });
    });

    group('getPopularMovies', () {
      test('deve buscar os filmes populares corretamente', () async {
        when(() => movieApi.getPopularMovies(page: page))
            .thenAnswer((_) async => MoviesModelFactory.getMoviesModel());

        final response = await movieRepositoryImpl.getPopularMovies(page: page);

        verify(() => movieApi.getPopularMovies(page: page)).called(1);

        expect(response, isA<AppResponse>());
        expect(response.hasError, isFalse);
        expect(response.success, isA<GetMoviesModel>());
        expect(response.error, isNull);
      });

      test('deve retornar response com error caso o mesmo seja um AppError',
          () async {
        when(() => movieApi.getPopularMovies(page: page))
            .thenThrow(AppError(stackTrace: StackTrace.current));

        final response = await movieRepositoryImpl.getPopularMovies(page: page);

        verify(() => movieApi.getPopularMovies(page: page)).called(1);

        expect(response, isA<AppResponse>());
        expect(response.hasError, isTrue);
        expect(response.success, isNull);
        expect(response.error, isA<AppError>());
      });

      test('deve retornar erro caso o mesmo seja genérico', () async {
        when(() => movieApi.getPopularMovies(page: page))
            .thenThrow(Exception());

        expect(
          () async => await movieRepositoryImpl.getPopularMovies(page: page),
          throwsA(isA<Exception>()),
        );

        verify(() => movieApi.getPopularMovies(page: page)).called(1);
      });
    });

    group('getTopRatedMovies', () {
      test('deve buscar os filmes melhores avaliados corretamente', () async {
        when(() => movieApi.getTopRatedMovies(page: page))
            .thenAnswer((_) async => MoviesModelFactory.getMoviesModel());

        final response =
            await movieRepositoryImpl.getTopRatedMovies(page: page);

        verify(() => movieApi.getTopRatedMovies(page: page)).called(1);

        expect(response, isA<AppResponse>());
        expect(response.hasError, isFalse);
        expect(response.success, isA<GetMoviesModel>());
        expect(response.error, isNull);
      });

      test('deve retornar response com error caso o mesmo seja um AppError',
          () async {
        when(() => movieApi.getTopRatedMovies(page: page))
            .thenThrow(AppError(stackTrace: StackTrace.current));

        final response =
            await movieRepositoryImpl.getTopRatedMovies(page: page);

        verify(() => movieApi.getTopRatedMovies(page: page)).called(1);

        expect(response, isA<AppResponse>());
        expect(response.hasError, isTrue);
        expect(response.success, isNull);
        expect(response.error, isA<AppError>());
      });

      test('deve retornar erro caso o mesmo seja genérico', () async {
        when(() => movieApi.getTopRatedMovies(page: page))
            .thenThrow(Exception());

        expect(
          () async => await movieRepositoryImpl.getTopRatedMovies(page: page),
          throwsA(isA<Exception>()),
        );

        verify(() => movieApi.getTopRatedMovies(page: page)).called(1);
      });
    });
  });
}
