import 'package:dio/dio.dart';
import 'package:flufflix/core/constants/index.dart';
import 'package:flufflix/core/repositories/response/index.dart';

class MovieRepository {
  final Dio client =
      Dio(BaseOptions(baseUrl: EnvConstants.instance.baseUrl, headers: {
    'Authorization': 'Bearer ${EnvConstants.instance.apiKey}'
  }, queryParameters: {
    'language': MoviesConstants.defaultPtBrLanguage,
  }));

  Future<GetPopularMoviesResponse> getPopularMovies(
      {int? page = MoviesConstants.defaultFirstPageMovies}) async {
    final response = await client.get('/movie/popular', queryParameters: {
      'page': page,
    });

    return GetPopularMoviesResponse.fromJson(response.data);
  }

  Future<GetTopRatedMoviesResponse> getTopRatedMovies(
      {int? page = MoviesConstants.defaultFirstPageMovies}) async {
    final response = await client.get('/movie/top_rated', queryParameters: {
      'page': page,
    });

    return GetTopRatedMoviesResponse.fromJson(response.data);
  }
}
