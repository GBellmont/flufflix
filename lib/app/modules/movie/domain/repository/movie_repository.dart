import 'package:flufflix/app/core/response/responses.dart';
import 'package:flufflix/app/modules/movie/domain/entity/entities.dart';

abstract class MovieRepository {
  Future<AppResponse<GetMoviesEntity<MovieEntity>>> getPopularMovies(
      {int? page});
  Future<AppResponse<GetMoviesEntity<MovieEntity>>> getTopRatedMovies(
      {int? page});
  Future<AppResponse<MovieDetailsEntity<CreditItemEntity>>> getMovieDetails(
      String id);
  Future<AppResponse<MovieTrailersEntity<TrailerEntity>>> getMovieTrailers(
      String id);
}
