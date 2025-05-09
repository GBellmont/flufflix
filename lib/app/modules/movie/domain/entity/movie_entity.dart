abstract class MovieEntity {
  final int id;
  final String title;
  final String imagePath;

  const MovieEntity(
      {required this.id, required this.title, required this.imagePath});
}
