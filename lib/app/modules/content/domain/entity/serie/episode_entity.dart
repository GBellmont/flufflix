abstract class EpisodeEntity {
  final String name;
  final String description;
  final String runtime;
  final String? image;

  const EpisodeEntity(
      {required this.name,
      required this.description,
      required this.runtime,
      this.image});
}
