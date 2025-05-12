import 'package:flufflix/app/core/constants/constants.dart';
import 'package:flufflix/app/core/error/errors.dart';

import 'package:flufflix/app/modules/content/data/model/models.dart';
import 'package:flufflix/app/modules/content/domain/contract/pagination_list_contract.dart';
import 'package:flufflix/app/modules/content/domain/entity/entities.dart';
import 'package:flufflix/app/modules/content/domain/interface/interfaces.dart';

class GetSeriesModel extends GetSeriesEntity<SerieModel>
    implements PaginationListInterface {
  final int totalPages;

  GetSeriesModel(
      {required super.page,
      required super.isFirst,
      required super.isLast,
      required super.list,
      required this.totalPages});

  factory GetSeriesModel.fromJson(Map<String, dynamic> jsonResponse) {
    try {
      final seriesList = (jsonResponse['results'] as List)
          .map((movie) => SerieModel.fromJson(movie))
          .toList();

      final totalPages = jsonResponse['total_pages'] ?? 0;
      final page =
          jsonResponse['page'] ?? ContentConstants.defaultFirstPageMovies;

      return GetSeriesModel(
          page: page,
          isFirst: (page == ContentConstants.defaultFirstPageMovies),
          isLast: (page >= totalPages),
          list: seriesList,
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
