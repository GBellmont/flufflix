class ContentListItemContract {
  final String? image;
  final String title;
  final String description;
  final String runtime;

  ContentListItemContract(
      {this.image,
      required this.title,
      required this.description,
      required this.runtime});
}
