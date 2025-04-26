import 'package:flufflix/components/pagination/contract/index.dart';
import 'package:flufflix/core/constants/index.dart';
import 'package:flufflix/core/models/index.dart';

class GetTopRatedMoviesResponse extends GetPaginationListContract<Movie> {
  const GetTopRatedMoviesResponse(
      int page, bool isFirst, bool isLast, List<Movie> list)
      : super(page: page, isFirst: isFirst, isLast: isLast, list: list);

  factory GetTopRatedMoviesResponse.fromJson(
      Map<String, dynamic> jsonResponse) {
    final moviesList = (jsonResponse['results'] as List)
        .map((movie) => Movie.fromJson(movie))
        .toList();

    final totalPages = jsonResponse['total_pages'] ?? 0;
    final page = jsonResponse['page'] ?? MoviesConstants.defaultFirstPageMovies;

    return GetTopRatedMoviesResponse(
        page,
        (page == MoviesConstants.defaultFirstPageMovies),
        (page >= totalPages),
        moviesList);
  }
}
