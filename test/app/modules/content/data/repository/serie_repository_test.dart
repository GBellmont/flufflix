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
const String seasonId = '456';
const int page = 123;

void main() {
  late final SerieApi serieApi;
  late final SerieRepositoryImpl serieRepositoryImpl;

  setUpAll(() async {
    serieApi = MockSerieApi();
    serieRepositoryImpl = SerieRepositoryImpl(serieApi: serieApi);
  });

  group('SerieRepositoryImplTest', () {
    group('getSerieDetails', () {
      test('deve buscar os detalhes de uma serie corretamente', () async {
        when(() => serieApi.getSerieDetails(id))
            .thenAnswer((_) async => SeriesModelFactory.getSerieDetailsModel());

        final response = await serieRepositoryImpl.getSerieDetails(id);

        verify(() => serieApi.getSerieDetails(id)).called(1);

        expect(response, isA<AppResponse>());
        expect(response.hasError, isFalse);
        expect(response.success, isA<SerieDetailsModel>());
        expect(response.error, isNull);
      });

      test('deve retornar response com error caso o mesmo seja um AppError',
          () async {
        when(() => serieApi.getSerieDetails(id))
            .thenThrow(AppError(stackTrace: StackTrace.current));

        final response = await serieRepositoryImpl.getSerieDetails(id);

        verify(() => serieApi.getSerieDetails(id)).called(1);

        expect(response, isA<AppResponse>());
        expect(response.hasError, isTrue);
        expect(response.success, isNull);
        expect(response.error, isA<AppError>());
      });

      test('deve retornar erro caso o mesmo seja genérico', () async {
        when(() => serieApi.getSerieDetails(id)).thenThrow(Exception());

        expect(
          () async => await serieRepositoryImpl.getSerieDetails(id),
          throwsA(isA<Exception>()),
        );

        verify(() => serieApi.getSerieDetails(id)).called(1);
      });
    });

    group('getSerieTrailers', () {
      test('deve buscar os trailers de uma serie corretamente', () async {
        when(() => serieApi.getSerieTrailers(id)).thenAnswer(
            (_) async => SeriesModelFactory.getSerieTrailersModel());

        final response = await serieRepositoryImpl.getSerieTrailers(id);

        verify(() => serieApi.getSerieTrailers(id)).called(1);

        expect(response, isA<AppResponse>());
        expect(response.hasError, isFalse);
        expect(response.success, isA<SerieTrailersModel>());
        expect(response.error, isNull);
      });

      test('deve retornar response com error caso o mesmo seja um AppError',
          () async {
        when(() => serieApi.getSerieTrailers(id))
            .thenThrow(AppError(stackTrace: StackTrace.current));

        final response = await serieRepositoryImpl.getSerieTrailers(id);

        verify(() => serieApi.getSerieTrailers(id)).called(1);

        expect(response, isA<AppResponse>());
        expect(response.hasError, isTrue);
        expect(response.success, isNull);
        expect(response.error, isA<AppError>());
      });

      test('deve retornar erro caso o mesmo seja genérico', () async {
        when(() => serieApi.getSerieTrailers(id)).thenThrow(Exception());

        expect(
          () async => await serieRepositoryImpl.getSerieTrailers(id),
          throwsA(isA<Exception>()),
        );

        verify(() => serieApi.getSerieTrailers(id)).called(1);
      });
    });

    group('getPopularSeries', () {
      test('deve buscar as series populares corretamente', () async {
        when(() => serieApi.getPopularSeries(page: page))
            .thenAnswer((_) async => SeriesModelFactory.getSeriesModel());

        final response = await serieRepositoryImpl.getPopularSeries(page: page);

        verify(() => serieApi.getPopularSeries(page: page)).called(1);

        expect(response, isA<AppResponse>());
        expect(response.hasError, isFalse);
        expect(response.success, isA<GetSeriesModel>());
        expect(response.error, isNull);
      });

      test('deve retornar response com error caso o mesmo seja um AppError',
          () async {
        when(() => serieApi.getPopularSeries(page: page))
            .thenThrow(AppError(stackTrace: StackTrace.current));

        final response = await serieRepositoryImpl.getPopularSeries(page: page);

        verify(() => serieApi.getPopularSeries(page: page)).called(1);

        expect(response, isA<AppResponse>());
        expect(response.hasError, isTrue);
        expect(response.success, isNull);
        expect(response.error, isA<AppError>());
      });

      test('deve retornar erro caso o mesmo seja genérico', () async {
        when(() => serieApi.getPopularSeries(page: page))
            .thenThrow(Exception());

        expect(
          () async => await serieRepositoryImpl.getPopularSeries(page: page),
          throwsA(isA<Exception>()),
        );

        verify(() => serieApi.getPopularSeries(page: page)).called(1);
      });
    });

    group('getTopRatedSeries', () {
      test('deve buscar os filmes melhores avaliados corretamente', () async {
        when(() => serieApi.getTopRatedSeries(page: page))
            .thenAnswer((_) async => SeriesModelFactory.getSeriesModel());

        final response =
            await serieRepositoryImpl.getTopRatedSeries(page: page);

        verify(() => serieApi.getTopRatedSeries(page: page)).called(1);

        expect(response, isA<AppResponse>());
        expect(response.hasError, isFalse);
        expect(response.success, isA<GetSeriesModel>());
        expect(response.error, isNull);
      });

      test('deve retornar response com error caso o mesmo seja um AppError',
          () async {
        when(() => serieApi.getTopRatedSeries(page: page))
            .thenThrow(AppError(stackTrace: StackTrace.current));

        final response =
            await serieRepositoryImpl.getTopRatedSeries(page: page);

        verify(() => serieApi.getTopRatedSeries(page: page)).called(1);

        expect(response, isA<AppResponse>());
        expect(response.hasError, isTrue);
        expect(response.success, isNull);
        expect(response.error, isA<AppError>());
      });

      test('deve retornar erro caso o mesmo seja genérico', () async {
        when(() => serieApi.getTopRatedSeries(page: page))
            .thenThrow(Exception());

        expect(
          () async => await serieRepositoryImpl.getTopRatedSeries(page: page),
          throwsA(isA<Exception>()),
        );

        verify(() => serieApi.getTopRatedSeries(page: page)).called(1);
      });
    });

    group('getSerieSeason', () {
      test('deve buscar os filmes melhores avaliados corretamente', () async {
        when(() => serieApi.getSerieSeason(id, seasonId))
            .thenAnswer((_) async => SeriesModelFactory.getSerieSeasonModel());

        final response = await serieRepositoryImpl.getSerieSeason(id, seasonId);

        verify(() => serieApi.getSerieSeason(id, seasonId)).called(1);

        expect(response, isA<AppResponse>());
        expect(response.hasError, isFalse);
        expect(response.success, isA<SerieSeasonModel>());
        expect(response.error, isNull);
      });

      test('deve retornar response com error caso o mesmo seja um AppError',
          () async {
        when(() => serieApi.getSerieSeason(id, seasonId))
            .thenThrow(AppError(stackTrace: StackTrace.current));

        final response = await serieRepositoryImpl.getSerieSeason(id, seasonId);

        verify(() => serieApi.getSerieSeason(id, seasonId)).called(1);

        expect(response, isA<AppResponse>());
        expect(response.hasError, isTrue);
        expect(response.success, isNull);
        expect(response.error, isA<AppError>());
      });

      test('deve retornar erro caso o mesmo seja genérico', () async {
        when(() => serieApi.getSerieSeason(id, seasonId))
            .thenThrow(Exception());

        expect(
          () async => await serieRepositoryImpl.getSerieSeason(id, seasonId),
          throwsA(isA<Exception>()),
        );

        verify(() => serieApi.getSerieSeason(id, seasonId)).called(1);
      });
    });
  });
}
