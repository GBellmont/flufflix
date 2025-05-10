import 'package:dio/dio.dart';
import 'package:flufflix/app/core/client/clients.dart';
import 'package:flufflix/app/core/error/errors.dart';
import 'package:flufflix/app/modules/movie/data/external/externals.dart';
import 'package:flufflix/app/modules/movie/data/model/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mock/factory/factories.dart';
import '../../../../../mock/mocks.dart';

void main() {
  late final HttpClient httpClient;
  late final MovieApi movieApi;

  setUpAll(() async {
    httpClient = MockHttpClient();
    movieApi = MovieApi(client: httpClient);
  });

  group('MovieApiTest', () {
    group('getPopularMovies', () {
      test('deve buscar os filmes populares corretamente com page default',
          () async {
        when(() => httpClient.get('/movie/popular', queryParameters: {
                  'page': 1,
                }))
            .thenAnswer((_) async =>
                HttpMoviesFactory.getMoviesModelJson(page: 1, totalPages: 10));

        final response = await movieApi.getPopularMovies();

        verify(() => httpClient.get('/movie/popular', queryParameters: {
              'page': 1,
            })).called(1);

        expect(response, isA<GetMoviesModel>());
      });

      test('deve buscar os filmes populares corretamente com page', () async {
        when(() => httpClient.get('/movie/popular', queryParameters: {
                  'page': 10,
                }))
            .thenAnswer((_) async =>
                HttpMoviesFactory.getMoviesModelJson(page: 10, totalPages: 10));

        final response = await movieApi.getPopularMovies(page: 10);

        verify(() => httpClient.get('/movie/popular', queryParameters: {
              'page': 10,
            })).called(1);

        expect(response, isA<GetMoviesModel>());
      });

      test(
          'deve retornar NetworkError quando o mesmo for do tipo de DioException',
          () async {
        when(() =>
                httpClient.get('/movie/popular', queryParameters: {'page': 1}))
            .thenThrow(DioException(
          requestOptions: RequestOptions(path: '/movie/popular'),
          error: 'Erro de rede',
          type: DioExceptionType.badResponse,
        ));

        expect(
          () async => await movieApi.getPopularMovies(),
          throwsA(isA<NetworkError>().having((e) => e.message, 'message',
              'An error occurred while fetching the list of popular movies.')),
        );

        verify(() => httpClient.get('/movie/popular', queryParameters: {
              'page': 1,
            })).called(1);
      });

      test('deve retornar erro de serialização corretamente', () async {
        when(() =>
                httpClient.get('/movie/popular', queryParameters: {'page': 1}))
            .thenAnswer((_) async =>
                HttpMoviesFactory.getMoviesModelSerializeErrorJson());

        expect(
          () async => await movieApi.getPopularMovies(),
          throwsA(isA<SerializerError>()),
        );

        verify(() => httpClient.get('/movie/popular', queryParameters: {
              'page': 1,
            })).called(1);
      });
    });

    group('getTopRatedMovies', () {
      test(
          'deve buscar os filmes melhor avaliados corretamente com page default',
          () async {
        when(() => httpClient.get('/movie/top_rated', queryParameters: {
                  'page': 1,
                }))
            .thenAnswer((_) async =>
                HttpMoviesFactory.getMoviesModelJson(page: 1, totalPages: 10));

        final response = await movieApi.getTopRatedMovies();

        verify(() => httpClient.get('/movie/top_rated', queryParameters: {
              'page': 1,
            })).called(1);

        expect(response, isA<GetMoviesModel>());
      });

      test('deve buscar os filmes populares corretamente com page', () async {
        when(() => httpClient.get('/movie/top_rated', queryParameters: {
                  'page': 10,
                }))
            .thenAnswer((_) async =>
                HttpMoviesFactory.getMoviesModelJson(page: 10, totalPages: 10));

        final response = await movieApi.getTopRatedMovies(page: 10);

        verify(() => httpClient.get('/movie/top_rated', queryParameters: {
              'page': 10,
            })).called(1);

        expect(response, isA<GetMoviesModel>());
      });

      test(
          'deve retornar NetworkError quando o mesmo for do tipo de DioException',
          () async {
        when(() => httpClient.get('/movie/top_rated',
            queryParameters: {'page': 1})).thenThrow(DioException(
          requestOptions: RequestOptions(path: '/movie/top_rated'),
          error: 'Erro de rede',
          type: DioExceptionType.badResponse,
        ));

        expect(
          () async => await movieApi.getTopRatedMovies(),
          throwsA(isA<NetworkError>().having((e) => e.message, 'message',
              'An error occurred while fetching the list of top rated movies.')),
        );

        verify(() => httpClient.get('/movie/top_rated', queryParameters: {
              'page': 1,
            })).called(1);
      });

      test('deve retornar erro de serialização corretamente', () async {
        when(() => httpClient
            .get('/movie/top_rated',
                queryParameters: {'page': 1})).thenAnswer(
            (_) async => HttpMoviesFactory.getMovieModelSerializeErrorJson());

        expect(
          () async => await movieApi.getTopRatedMovies(),
          throwsA(isA<SerializerError>()),
        );

        verify(() => httpClient.get('/movie/top_rated', queryParameters: {
              'page': 1,
            })).called(1);
      });
    });

    group('getMovieDetails', () {
      const String id = '123';

      test('deve buscar os detalhes do filme corretamente', () async {
        when(() => httpClient.get('/movie/$id',
                queryParameters: {'append_to_response': 'credits'}))
            .thenAnswer(
                (_) async => HttpMoviesFactory.getMovieDetailsModelJson());

        final response = await movieApi.getMovieDetails(id);

        verify(() => httpClient.get('/movie/$id',
            queryParameters: {'append_to_response': 'credits'})).called(1);

        expect(response, isA<MovieDetailsModel>());
      });

      test(
          'deve retornar NetworkError quando o mesmo for do tipo de DioException',
          () async {
        when(() => httpClient.get('/movie/$id',
                queryParameters: {'append_to_response': 'credits'}))
            .thenThrow(DioException(
          requestOptions: RequestOptions(path: '/movie/$id'),
          error: 'Erro de rede',
          type: DioExceptionType.badResponse,
        ));

        expect(
          () async => await movieApi.getMovieDetails(id),
          throwsA(isA<NetworkError>().having((e) => e.message, 'message',
              'An error occurred while fetching movie details.')),
        );

        verify(() => httpClient.get('/movie/$id',
            queryParameters: {'append_to_response': 'credits'})).called(1);
      });

      test(
          'deve retornar erro de serialização corretamente na serialização dos detalhes',
          () async {
        when(() => httpClient.get('/movie/$id',
                queryParameters: {'append_to_response': 'credits'}))
            .thenAnswer((_) async =>
                HttpMoviesFactory.getMovieDetailsModelSerializeErrorJson());

        expect(
          () async => await movieApi.getMovieDetails(id),
          throwsA(isA<SerializerError>()),
        );

        verify(() => httpClient.get('/movie/$id',
            queryParameters: {'append_to_response': 'credits'})).called(1);
      });

      test(
          'deve retornar erro de serialização corretamente na serialização dos créditos',
          () async {
        when(() => httpClient.get('/movie/$id',
                queryParameters: {'append_to_response': 'credits'}))
            .thenAnswer((_) async => HttpMoviesFactory
                .getMovieDetailsCreditItemModelSerializeErrorJson());

        expect(
          () async => await movieApi.getMovieDetails(id),
          throwsA(isA<SerializerError>()),
        );

        verify(() => httpClient.get('/movie/$id',
            queryParameters: {'append_to_response': 'credits'})).called(1);
      });
    });

    group('getMovieTrailers', () {
      const String id = '123';

      test('deve buscar os trilers de um filme corretamente', () async {
        when(() => httpClient.get('/movie/$id/videos')).thenAnswer(
            (_) async => HttpMoviesFactory.getMovieTrailersModelJson());

        final response = await movieApi.getMovieTrailers(id);

        verify(() => httpClient.get('/movie/$id/videos')).called(1);

        expect(response, isA<MovieTrailersModel>());
      });

      test(
          'deve retornar NetworkError quando o mesmo for do tipo de DioException',
          () async {
        when(() => httpClient.get('/movie/$id/videos')).thenThrow(DioException(
          requestOptions: RequestOptions(path: '/movie/$id/videos'),
          error: 'Erro de rede',
          type: DioExceptionType.badResponse,
        ));

        expect(
          () async => await movieApi.getMovieTrailers(id),
          throwsA(isA<NetworkError>().having((e) => e.message, 'message',
              'An error occurred while fetching movie trailers.')),
        );

        verify(() => httpClient.get('/movie/$id/videos')).called(1);
      });

      test(
          'deve retornar erro de serialização corretamente na serialização da lista de trailers',
          () async {
        when(() => httpClient.get('/movie/$id/videos')).thenAnswer((_) async =>
            HttpMoviesFactory.getMovieTrailersModelSerializeErroJson());

        expect(
          () async => await movieApi.getMovieTrailers(id),
          throwsA(isA<SerializerError>()),
        );

        verify(() => httpClient.get('/movie/$id/videos')).called(1);
      });

      test(
          'deve retornar erro de serialização corretamente na serialização dos trailers',
          () async {
        when(() => httpClient.get('/movie/$id/videos')).thenAnswer((_) async =>
            HttpMoviesFactory.getMovieTrailerModelSerializeErrorJson());

        expect(
          () async => await movieApi.getMovieTrailers(id),
          throwsA(isA<SerializerError>()),
        );

        verify(() => httpClient.get('/movie/$id/videos')).called(1);
      });
    });
  });
}
