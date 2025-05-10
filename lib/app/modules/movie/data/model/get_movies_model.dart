import 'package:flufflix/app/core/constants/constants.dart';
import 'package:flufflix/app/core/error/errors.dart';
import 'package:flufflix/app/modules/movie/data/model/models.dart';
import 'package:flufflix/app/modules/movie/domain/contract/contracts.dart';
import 'package:flufflix/app/modules/movie/domain/entity/entities.dart';
import 'package:flufflix/app/modules/movie/domain/interface/interfaces.dart';

class GetMoviesModel extends GetMoviesEntity<MovieModel>
    implements PaginationListInterface {
  final int totalPages;

  const GetMoviesModel({
    required this.totalPages,
    required super.isFirst,
    required super.isLast,
    required super.page,
    required super.list,
  });

  factory GetMoviesModel.fromJson(Map<String, dynamic> jsonResponse) {
    try {
      final moviesList = (jsonResponse['results'] as List)
          .map((movie) => MovieModel.fromJson(movie))
          .toList();

      final totalPages = jsonResponse['total_pages'] ?? 0;
      final page =
          jsonResponse['page'] ?? MoviesConstants.defaultFirstPageMovies;

      return GetMoviesModel(
          page: page,
          isFirst: (page == MoviesConstants.defaultFirstPageMovies),
          isLast: (page >= totalPages),
          list: moviesList,
          totalPages: totalPages);
    } catch (error, stackTrace) {
      throw SerializerError(stackTrace: stackTrace, error: error);
    }
  }

  @override
  PaginationListContract toPaginationListContract() {
    return PaginationListContract(
        page: page,
        isFirst: isFirst,
        isLast: isLast,
        list: list.map((item) => item.toPaginationCardContract()).toList());
  }
}
