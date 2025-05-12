import 'package:flufflix/app/modules/content/data/model/models.dart';

import '../factories.dart';

class SeriesModelFactory {
  static SerieDetailsModel getSerieDetailsModel() {
    return SerieDetailsModel.fromJson(
        HttpSeriesFactory.getSerieDetailsModelJson().data);
  }

  static SerieTrailersModel getSerieTrailersModel() {
    return SerieTrailersModel.fromJson(
        HttpSeriesFactory.getSerieTrailersModelJson().data);
  }

  static GetSeriesModel getSeriesModel() {
    return GetSeriesModel.fromJson(
        HttpSeriesFactory.getSeriesModelJson(page: 1, totalPages: 10).data);
  }

  static SerieSeasonModel getSerieSeasonModel() {
    return SerieSeasonModel.fromJson(
        HttpSeriesFactory.getSerieSeasonModelJson().data);
  }
}
