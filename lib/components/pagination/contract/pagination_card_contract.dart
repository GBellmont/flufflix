abstract class PaginationCardContract {
  final int id;
  final String title;
  final String imagePath;

  const PaginationCardContract(
      {required this.id, required this.title, required this.imagePath});
}
