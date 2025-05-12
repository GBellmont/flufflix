import 'package:dio/dio.dart';

import 'package:flufflix/app/core/client/clients.dart';
import 'package:flufflix/app/core/constants/constants.dart';
import 'package:flufflix/app/core/error/app_error.dart';

import 'package:flufflix/app/modules/content/data/model/models.dart';

class SerieApi {
  final HttpClient client;

  SerieApi({required this.client});

  Future<GetSeriesModel> getPopularSeries(
      {int? page = ContentConstants.defaultFirstPageMovies}) async {
    try {
      final response = await client.get('/tv/popular', queryParameters: {
        'page': page,
      });

      return GetSeriesModel.fromJson(response.data);
    } on DioException catch (error, stackTrace) {
      throw NetworkError(
          stackTrace: stackTrace,
          error: error,
          message:
              'An error occurred while fetching the list of popular series.');
    } catch (error, _) {
      rethrow;
    }
  }

  Future<GetSeriesModel> getTopRatedSeries(
      {int? page = ContentConstants.defaultFirstPageMovies}) async {
    try {
      final response = await client.get('/tv/top_rated', queryParameters: {
        'page': page,
      });

      return GetSeriesModel.fromJson(response.data);
    } on DioException catch (error, stackTrace) {
      throw NetworkError(
          stackTrace: stackTrace,
          error: error,
          message:
              'An error occurred while fetching the list of top rated series.');
    } catch (error, _) {
      rethrow;
    }
  }

  Future<SerieDetailsModel> getSerieDetails(String id) async {
    try {
      final response = await client.get('/tv/$id', queryParameters: {
        'append_to_response': 'credits',
      });

      return SerieDetailsModel.fromJson(response.data);
    } on DioException catch (error, stackTrace) {
      throw NetworkError(
          stackTrace: stackTrace,
          error: error,
          message: 'An error occurred while fetching serie details.');
    } catch (error, _) {
      rethrow;
    }
  }

  Future<SerieTrailersModel> getSerieTrailers(String id) async {
    try {
      final response = await client.get('/tv/$id/videos');

      return SerieTrailersModel.fromJson(response.data);
    } on DioException catch (error, stackTrace) {
      throw NetworkError(
          stackTrace: stackTrace,
          error: error,
          message: 'An error occurred while fetching serie trailers.');
    } catch (error, _) {
      rethrow;
    }
  }

  Future<SerieSeasonModel> getSerieSeason(
      String id, String seasonNumber) async {
    try {
      final response = await client.get('/tv/$id/season/$seasonNumber');

      return SerieSeasonModel.fromJson(response.data);
    } on DioException catch (error, stackTrace) {
      throw NetworkError(
          stackTrace: stackTrace,
          error: error,
          message: 'An error occurred while fetching serie season.');
    } catch (error, _) {
      rethrow;
    }
  }
}
