import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flufflix/app/core/client/clients.dart';
import 'package:flufflix/app/core/error/errors.dart';

import 'package:flufflix/app/modules/content/data/external/serie_api.dart';
import 'package:flufflix/app/modules/content/data/model/models.dart';

import '../../../../../mock/factory/content/http_series_factory.dart';
import '../../../../../mock/mocks.dart';

void main() {
  late final HttpClient httpClient;
  late final SerieApi serieApi;

  setUpAll(() {
    httpClient = MockHttpClient();
    serieApi = SerieApi(client: httpClient);
  });

  group('SerieApiTest', () {
    group('getPopularSeries', () {
      test('deve buscar as series populares corretamente com page default',
          () async {
        when(() => httpClient.get('/tv/popular', queryParameters: {
                  'page': 1,
                }))
            .thenAnswer((_) async =>
                HttpSeriesFactory.getSeriesModelJson(page: 1, totalPages: 10));

        final response = await serieApi.getPopularSeries();

        verify(() => httpClient.get('/tv/popular', queryParameters: {
              'page': 1,
            })).called(1);

        expect(response, isA<GetSeriesModel>());
      });

      test('deve buscar as series populares corretamente com page', () async {
        when(() => httpClient.get('/tv/popular', queryParameters: {
                  'page': 10,
                }))
            .thenAnswer((_) async =>
                HttpSeriesFactory.getSeriesModelJson(page: 10, totalPages: 10));

        final response = await serieApi.getPopularSeries(page: 10);

        verify(() => httpClient.get('/tv/popular', queryParameters: {
              'page': 10,
            })).called(1);

        expect(response, isA<GetSeriesModel>());
      });

      test(
          'deve retornar NetworkError quando o mesmo for do tipo de DioException',
          () async {
        when(() => httpClient.get('/tv/popular', queryParameters: {'page': 1}))
            .thenThrow(DioException(
          requestOptions: RequestOptions(path: '/tv/popular'),
          error: 'Erro de rede',
          type: DioExceptionType.badResponse,
        ));

        expect(
          () async => await serieApi.getPopularSeries(),
          throwsA(isA<NetworkError>().having((e) => e.message, 'message',
              'An error occurred while fetching the list of popular series.')),
        );

        verify(() => httpClient.get('/tv/popular', queryParameters: {
              'page': 1,
            })).called(1);
      });

      test('deve retornar erro de serialização corretamente', () async {
        when(() => httpClient.get('/tv/popular', queryParameters: {'page': 1}))
            .thenAnswer((_) async =>
                HttpSeriesFactory.getSeriesModelSerializeErrorJson());

        expect(
          () async => await serieApi.getPopularSeries(),
          throwsA(isA<SerializerError>()),
        );

        verify(() => httpClient.get('/tv/popular', queryParameters: {
              'page': 1,
            })).called(1);
      });
    });

    group('getTopRatedSeries', () {
      test('deve buscar as series populares corretamente com page default',
          () async {
        when(() => httpClient.get('/tv/top_rated', queryParameters: {
                  'page': 1,
                }))
            .thenAnswer((_) async =>
                HttpSeriesFactory.getSeriesModelJson(page: 1, totalPages: 10));

        final response = await serieApi.getTopRatedSeries();

        verify(() => httpClient.get('/tv/top_rated', queryParameters: {
              'page': 1,
            })).called(1);

        expect(response, isA<GetSeriesModel>());
      });

      test('deve buscar as series populares corretamente com page', () async {
        when(() => httpClient.get('/tv/top_rated', queryParameters: {
                  'page': 10,
                }))
            .thenAnswer((_) async =>
                HttpSeriesFactory.getSeriesModelJson(page: 10, totalPages: 10));

        final response = await serieApi.getTopRatedSeries(page: 10);

        verify(() => httpClient.get('/tv/top_rated', queryParameters: {
              'page': 10,
            })).called(1);

        expect(response, isA<GetSeriesModel>());
      });

      test(
          'deve retornar NetworkError quando o mesmo for do tipo de DioException',
          () async {
        when(() =>
                httpClient.get('/tv/top_rated', queryParameters: {'page': 1}))
            .thenThrow(DioException(
          requestOptions: RequestOptions(path: '/tv/top_rated'),
          error: 'Erro de rede',
          type: DioExceptionType.badResponse,
        ));

        expect(
          () async => await serieApi.getTopRatedSeries(),
          throwsA(isA<NetworkError>().having((e) => e.message, 'message',
              'An error occurred while fetching the list of top rated series.')),
        );

        verify(() => httpClient.get('/tv/top_rated', queryParameters: {
              'page': 1,
            })).called(1);
      });

      test('deve retornar erro de serialização corretamente', () async {
        when(() =>
                httpClient.get('/tv/top_rated', queryParameters: {'page': 1}))
            .thenAnswer((_) async =>
                HttpSeriesFactory.getSerieModelSerializeErrorJson());

        expect(
          () async => await serieApi.getTopRatedSeries(),
          throwsA(isA<SerializerError>()),
        );

        verify(() => httpClient.get('/tv/top_rated', queryParameters: {
              'page': 1,
            })).called(1);
      });
    });

    group('getSerieDetails', () {
      const String id = '123';

      test('deve buscar os detalhes da serie corretamente', () async {
        when(() => httpClient.get('/tv/$id',
                queryParameters: {'append_to_response': 'credits'}))
            .thenAnswer(
                (_) async => HttpSeriesFactory.getSerieDetailsModelJson());

        final response = await serieApi.getSerieDetails(id);

        verify(() => httpClient.get('/tv/$id',
            queryParameters: {'append_to_response': 'credits'})).called(1);

        expect(response, isA<SerieDetailsModel>());
      });

      test(
          'deve retornar NetworkError quando o mesmo for do tipo de DioException',
          () async {
        when(() => httpClient.get('/tv/$id',
                queryParameters: {'append_to_response': 'credits'}))
            .thenThrow(DioException(
          requestOptions: RequestOptions(path: '/tv/$id'),
          error: 'Erro de rede',
          type: DioExceptionType.badResponse,
        ));

        expect(
          () async => await serieApi.getSerieDetails(id),
          throwsA(isA<NetworkError>().having((e) => e.message, 'message',
              'An error occurred while fetching serie details.')),
        );

        verify(() => httpClient.get('/tv/$id',
            queryParameters: {'append_to_response': 'credits'})).called(1);
      });

      test(
          'deve retornar erro de serialização corretamente na serialização dos detalhes',
          () async {
        when(() => httpClient.get('/tv/$id',
                queryParameters: {'append_to_response': 'credits'}))
            .thenAnswer((_) async =>
                HttpSeriesFactory.getSerieDetailsModelSerializeErrorJson());

        expect(
          () async => await serieApi.getSerieDetails(id),
          throwsA(isA<SerializerError>()),
        );

        verify(() => httpClient.get('/tv/$id',
            queryParameters: {'append_to_response': 'credits'})).called(1);
      });

      test(
          'deve retornar erro de serialização corretamente na serialização dos créditos',
          () async {
        when(() => httpClient.get('/tv/$id',
                queryParameters: {'append_to_response': 'credits'}))
            .thenAnswer((_) async => HttpSeriesFactory
                .getSerieDetailsCreditItemModelSerializeErrorJson());

        expect(
          () async => await serieApi.getSerieDetails(id),
          throwsA(isA<SerializerError>()),
        );

        verify(() => httpClient.get('/tv/$id',
            queryParameters: {'append_to_response': 'credits'})).called(1);
      });
    });

    group('getSerieTrailers', () {
      const String id = '123';

      test('deve buscar os trailers de uma serie corretamente', () async {
        when(() => httpClient.get('/tv/$id/videos')).thenAnswer(
            (_) async => HttpSeriesFactory.getSerieTrailersModelJson());

        final response = await serieApi.getSerieTrailers(id);

        verify(() => httpClient.get('/tv/$id/videos')).called(1);

        expect(response, isA<SerieTrailersModel>());
      });

      test(
          'deve retornar NetworkError quando o mesmo for do tipo de DioException',
          () async {
        when(() => httpClient.get('/tv/$id/videos')).thenThrow(DioException(
          requestOptions: RequestOptions(path: '/tv/$id/videos'),
          error: 'Erro de rede',
          type: DioExceptionType.badResponse,
        ));

        expect(
          () async => await serieApi.getSerieTrailers(id),
          throwsA(isA<NetworkError>().having((e) => e.message, 'message',
              'An error occurred while fetching serie trailers.')),
        );

        verify(() => httpClient.get('/tv/$id/videos')).called(1);
      });

      test(
          'deve retornar erro de serialização corretamente na serialização da lista de trailers',
          () async {
        when(() => httpClient.get('/tv/$id/videos')).thenAnswer((_) async =>
            HttpSeriesFactory.getSerieTrailersModelSerializeErroJson());

        expect(
          () async => await serieApi.getSerieTrailers(id),
          throwsA(isA<SerializerError>()),
        );

        verify(() => httpClient.get('/tv/$id/videos')).called(1);
      });

      test(
          'deve retornar erro de serialização corretamente na serialização dos trailers',
          () async {
        when(() => httpClient.get('/tv/$id/videos')).thenAnswer((_) async =>
            HttpSeriesFactory.getSerieTrailerModelSerializeErrorJson());

        expect(
          () async => await serieApi.getSerieTrailers(id),
          throwsA(isA<SerializerError>()),
        );

        verify(() => httpClient.get('/tv/$id/videos')).called(1);
      });
    });

    group('getSerieSeason', () {
      const String id = '123';
      const String seasonNumber = '456';

      test('deve buscar a temporada de uma serie corretamente', () async {
        when(() => httpClient.get('/tv/$id/season/$seasonNumber')).thenAnswer(
            (_) async => HttpSeriesFactory.getSerieSeasonModelJson());

        final response = await serieApi.getSerieSeason(id, seasonNumber);

        verify(() => httpClient.get('/tv/$id/season/$seasonNumber')).called(1);

        expect(response, isA<SerieSeasonModel>());
      });

      test(
          'deve retornar NetworkError quando o mesmo for do tipo de DioException',
          () async {
        when(() => httpClient.get('/tv/$id/season/$seasonNumber'))
            .thenThrow(DioException(
          requestOptions: RequestOptions(path: '/tv/$id/season/$seasonNumber'),
          error: 'Erro de rede',
          type: DioExceptionType.badResponse,
        ));

        expect(
          () async => await serieApi.getSerieSeason(id, seasonNumber),
          throwsA(isA<NetworkError>().having((e) => e.message, 'message',
              'An error occurred while fetching serie season.')),
        );

        verify(() => httpClient.get('/tv/$id/season/$seasonNumber')).called(1);
      });

      test(
          'deve retornar erro de serialização corretamente na serialização da lista de episódios',
          () async {
        when(() => httpClient.get('/tv/$id/season/$seasonNumber')).thenAnswer(
            (_) async =>
                HttpSeriesFactory.getSerieSeasonModelSerializeErroJson());

        expect(
          () async => await serieApi.getSerieSeason(id, seasonNumber),
          throwsA(isA<SerializerError>()),
        );

        verify(() => httpClient.get('/tv/$id/season/$seasonNumber')).called(1);
      });

      test(
          'deve retornar erro de serialização corretamente na serialização dos episódios',
          () async {
        when(() => httpClient.get('/tv/$id/season/$seasonNumber')).thenAnswer(
            (_) async =>
                HttpSeriesFactory.getSerieEpisodeModelSerializeErrorJson());

        expect(
          () async => await serieApi.getSerieSeason(id, seasonNumber),
          throwsA(isA<SerializerError>()),
        );

        verify(() => httpClient.get('/tv/$id/season/$seasonNumber')).called(1);
      });
    });
  });
}
