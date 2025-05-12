abstract class MovieEntity {
  final int id;
  final String title;
  final String imagePath;
  final String releaseDate;

  const MovieEntity(
      {required this.id,
      required this.title,
      required this.imagePath,
      required this.releaseDate});
}
