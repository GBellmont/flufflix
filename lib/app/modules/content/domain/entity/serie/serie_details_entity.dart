import 'package:flufflix/app/modules/content/domain/entity/entities.dart';

abstract class SerieDetailsEntity<T extends CreditItemEntity> {
  final int id;
  final String title;
  final String description;
  final String posterImage;
  final String bannerImage;
  final String? firstAirDate;
  final bool forAdult;
  final String? greatherRuntime;
  final double average;
  final List<T> starringActors;
  final List<T> creators;
  final List<String> genres;
  final int seasonsNumber;

  const SerieDetailsEntity(
      {required this.id,
      required this.title,
      required this.description,
      required this.posterImage,
      required this.bannerImage,
      this.firstAirDate,
      required this.forAdult,
      this.greatherRuntime,
      required this.average,
      required this.starringActors,
      required this.creators,
      required this.genres,
      required this.seasonsNumber});
}
