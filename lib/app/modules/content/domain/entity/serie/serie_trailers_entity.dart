import 'package:flufflix/app/modules/content/domain/entity/trailer_entity.dart';

abstract class SerieTrailersEntity<T extends TrailerEntity> {
  final List<T> trailers;

  const SerieTrailersEntity({required this.trailers});
}
