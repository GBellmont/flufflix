import 'dart:convert';

import 'package:flufflix/components/pagination/contract/index.dart';
import 'package:flufflix/core/constants/index.dart';
import 'package:flufflix/core/models/index.dart';

class GetPopularMoviesResponse extends GetPaginationListContract<Movie> {
  final int totalPages;

  const GetPopularMoviesResponse(
      int page, bool isFirst, bool isLast, List<Movie> list, this.totalPages)
      : super(page: page, isFirst: isFirst, isLast: isLast, list: list);

  factory GetPopularMoviesResponse.fromJson(Map<String, dynamic> jsonResponse) {
    final moviesList = (jsonResponse['results'] as List)
        .map((movie) => Movie.fromJson(movie))
        .toList();

    final totalPages = jsonResponse['total_pages'] ?? 0;
    final page = jsonResponse['page'] ?? MoviesConstants.defaultFirstPageMovies;

    return GetPopularMoviesResponse(
        page,
        (page == MoviesConstants.defaultFirstPageMovies),
        (page >= totalPages),
        moviesList,
        totalPages);
  }

  String get toJson => jsonEncode({
        'results': list.map((item) => item.toJson).toList(),
        'total_pages': totalPages,
        'page': page
      });
}
