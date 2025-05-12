import 'package:flufflix/app/core/error/errors.dart';
import 'package:flufflix/app/core/response/app_response.dart';

import 'package:flufflix/app/modules/content/data/external/serie_api.dart';
import 'package:flufflix/app/modules/content/data/model/models.dart';
import 'package:flufflix/app/modules/content/domain/repository/repositories.dart';

class SerieRepositoryImpl implements SerieRepository {
  final SerieApi serieApi;

  const SerieRepositoryImpl({required this.serieApi});

  @override
  Future<AppResponse<GetSeriesModel>> getPopularSeries({int? page}) async {
    try {
      final response = await serieApi.getPopularSeries(page: page);

      return AppResponse<GetSeriesModel>(success: response);
    } on AppError catch (error, _) {
      return AppResponse<GetSeriesModel>(error: error);
    } catch (error, _) {
      rethrow;
    }
  }

  @override
  Future<AppResponse<GetSeriesModel>> getTopRatedSeries({int? page}) async {
    try {
      final response = await serieApi.getTopRatedSeries(page: page);

      return AppResponse<GetSeriesModel>(success: response);
    } on AppError catch (error, _) {
      return AppResponse<GetSeriesModel>(error: error);
    } catch (error, _) {
      rethrow;
    }
  }

  @override
  Future<AppResponse<SerieDetailsModel>> getSerieDetails(String id) async {
    try {
      final response = await serieApi.getSerieDetails(id);

      return AppResponse<SerieDetailsModel>(success: response);
    } on AppError catch (error, _) {
      return AppResponse<SerieDetailsModel>(error: error);
    } catch (error, _) {
      rethrow;
    }
  }

  @override
  Future<AppResponse<SerieSeasonModel>> getSerieSeason(
      String id, String seasonId) async {
    try {
      final response = await serieApi.getSerieSeason(id, seasonId);

      return AppResponse<SerieSeasonModel>(success: response);
    } on AppError catch (error, _) {
      return AppResponse<SerieSeasonModel>(error: error);
    } catch (error, _) {
      rethrow;
    }
  }

  @override
  Future<AppResponse<SerieTrailersModel>> getSerieTrailers(String id) async {
    try {
      final response = await serieApi.getSerieTrailers(id);

      return AppResponse<SerieTrailersModel>(success: response);
    } on AppError catch (error, _) {
      return AppResponse<SerieTrailersModel>(error: error);
    } catch (error, _) {
      rethrow;
    }
  }
}
