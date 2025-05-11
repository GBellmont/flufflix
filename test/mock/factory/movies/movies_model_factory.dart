import 'package:flufflix/app/modules/movie/data/model/models.dart';

import '../factories.dart';

class MoviesModelFactory {
  static MovieDetailsModel getMovieDetailsModel() {
    return MovieDetailsModel.fromJson(
        HttpMoviesFactory.getMovieDetailsModelJson().data);
  }

  static MovieTrailersModel getMovieTrailersModel() {
    return MovieTrailersModel.fromJson(
        HttpMoviesFactory.getMovieTrailersModelJson().data);
  }

  static GetMoviesModel getMoviesModel() {
    return GetMoviesModel.fromJson(
        HttpMoviesFactory.getMoviesModelJson(page: 1, totalPages: 10).data);
  }
}
