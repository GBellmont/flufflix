import 'package:dio/dio.dart';
import 'package:flufflix/app/core/client/clients.dart';
import 'package:flufflix/app/core/constants/constants.dart';
import 'package:flufflix/app/core/error/errors.dart';
import 'package:flufflix/app/modules/movie/data/model/models.dart';

class MovieApi {
  final HttpClient client;

  const MovieApi({required this.client});

  Future<GetMoviesModel> getPopularMovies(
      {int? page = MoviesConstants.defaultFirstPageMovies}) async {
    try {
      final response = await client.get('/movie/popular', queryParameters: {
        'page': page,
      });

      return GetMoviesModel.fromJson(response.data);
    } on DioException catch (error, stackTrace) {
      throw NetworkError(
          stackTrace: stackTrace,
          error: error,
          message:
              'An error occurred while fetching the list of popular movies.');
    } catch (error, _) {
      rethrow;
    }
  }

  Future<GetMoviesModel> getTopRatedMovies(
      {int? page = MoviesConstants.defaultFirstPageMovies}) async {
    try {
      final response = await client.get('/movie/top_rated', queryParameters: {
        'page': page,
      });

      return GetMoviesModel.fromJson(response.data);
    } on DioException catch (error, stackTrace) {
      throw NetworkError(
          stackTrace: stackTrace,
          error: error,
          message:
              'An error occurred while fetching the list of top rated movies.');
    } catch (error, _) {
      rethrow;
    }
  }

  Future<MovieDetailsModel> getMovieDetails(String id) async {
    try {
      final response = await client.get('/movie/$id',
          queryParameters: {'append_to_response': 'credits'});

      return MovieDetailsModel.fromJson(response.data);
    } on DioException catch (error, stackTrace) {
      throw NetworkError(
          stackTrace: stackTrace,
          error: error,
          message: 'An error occurred while fetching movie details.');
    } catch (error, _) {
      rethrow;
    }
  }

  Future<MovieTrailersModel> getMovieTrailers(String id) async {
    try {
      final response = await client.get('/movie/$id/videos');

      return MovieTrailersModel.fromJson(response.data);
    } on DioException catch (error, stackTrace) {
      throw NetworkError(
          stackTrace: stackTrace,
          error: error,
          message: 'An error occurred while fetching movie trailers.');
    } catch (error, _) {
      rethrow;
    }
  }
}
