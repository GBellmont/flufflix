import 'package:flufflix/app/modules/content/domain/entity/entities.dart';

abstract class SerieSeasonEntity<T extends EpisodeEntity> {
  final List<T> episodes;

  const SerieSeasonEntity({required this.episodes});
}
