import 'package:flufflix/app/modules/content/domain/entity/entities.dart';

abstract class MovieDetailsEntity<T extends CreditItemEntity> {
  final int id;
  final String title;
  final String description;
  final String posterImage;
  final String bannerImage;
  final String? releaseDate;
  final bool forAdult;
  final String runtime;
  final String collectionName;
  final double average;
  final List<T> starringActors;
  final List<T> directors;
  final List<String> genres;

  const MovieDetailsEntity(
      {required this.id,
      required this.title,
      required this.description,
      required this.posterImage,
      required this.bannerImage,
      this.releaseDate,
      required this.forAdult,
      required this.runtime,
      required this.collectionName,
      required this.average,
      required this.starringActors,
      required this.directors,
      required this.genres});
}
