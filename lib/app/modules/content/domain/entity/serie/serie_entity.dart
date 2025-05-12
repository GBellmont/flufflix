abstract class SerieEntity {
  final int id;
  final String name;
  final String imagePath;
  final String firstAirDate;

  const SerieEntity(
      {required this.id,
      required this.name,
      required this.imagePath,
      required this.firstAirDate});
}
