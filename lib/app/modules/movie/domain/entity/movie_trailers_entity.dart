import 'package:flufflix/app/modules/movie/domain/entity/trailer_entity.dart';

abstract class MovieTrailersEntity<T extends TrailerEntity> {
  final List<T> trailers;

  const MovieTrailersEntity({required this.trailers});
}
