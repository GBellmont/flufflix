import 'package:flufflix/app/core/error/errors.dart';
import 'package:flufflix/app/core/response/responses.dart';
import 'package:flufflix/app/modules/movie/data/external/externals.dart';
import 'package:flufflix/app/modules/movie/data/model/models.dart';
import 'package:flufflix/app/modules/movie/domain/repository/repositories.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieApi movieApi;

  const MovieRepositoryImpl({required this.movieApi});

  @override
  Future<AppResponse<MovieDetailsModel>> getMovieDetails(String id) async {
    try {
      final response = await movieApi.getMovieDetails(id);

      return AppResponse<MovieDetailsModel>(success: response);
    } on AppError catch (error, _) {
      return AppResponse<MovieDetailsModel>(error: error);
    } catch (error, _) {
      rethrow;
    }
  }

  @override
  Future<AppResponse<MovieTrailersModel>> getMovieTrailers(String id) async {
    try {
      final response = await movieApi.getMovieTrailers(id);

      return AppResponse<MovieTrailersModel>(success: response);
    } on AppError catch (error, _) {
      return AppResponse<MovieTrailersModel>(error: error);
    } catch (error, _) {
      rethrow;
    }
  }

  @override
  Future<AppResponse<GetMoviesModel>> getPopularMovies({int? page}) async {
    try {
      final response = await movieApi.getPopularMovies(page: page);

      return AppResponse<GetMoviesModel>(success: response);
    } on AppError catch (error, _) {
      return AppResponse<GetMoviesModel>(error: error);
    } catch (error, _) {
      rethrow;
    }
  }

  @override
  Future<AppResponse<GetMoviesModel>> getTopRatedMovies({int? page}) async {
    try {
      final response = await movieApi.getTopRatedMovies(page: page);

      return AppResponse<GetMoviesModel>(success: response);
    } on AppError catch (error, _) {
      return AppResponse<GetMoviesModel>(error: error);
    } catch (error, _) {
      rethrow;
    }
  }
}
