import 'package:flufflix/app/core/response/responses.dart';

import 'package:flufflix/app/modules/content/domain/entity/entities.dart';

abstract class SerieRepository {
  Future<AppResponse<GetSeriesEntity<SerieEntity>>> getPopularSeries(
      {int? page});
  Future<AppResponse<GetSeriesEntity<SerieEntity>>> getTopRatedSeries(
      {int? page});
  Future<AppResponse<SerieDetailsEntity<CreditItemEntity>>> getSerieDetails(
      String id);
  Future<AppResponse<SerieTrailersEntity<TrailerEntity>>> getSerieTrailers(
      String id);
  Future<AppResponse<SerieSeasonEntity<EpisodeEntity>>> getSerieSeason(
      String id, String seasonId);
}
