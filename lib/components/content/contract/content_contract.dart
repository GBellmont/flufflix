abstract class ContentContractInterface {
  ContentContract toContentContract();
}

class ContentContract {
  final int id;
  final String title;
  final String description;
  final String runtime;
  final String posterImage;
  final String bannerImage;
  final String tags;
  final String starring;
  final String creators;
  final String genres;

  ContentContract(
      {required this.id,
      required this.title,
      required this.description,
      required this.runtime,
      required this.posterImage,
      required this.bannerImage,
      required this.tags,
      required this.starring,
      required this.creators,
      required this.genres});
}
