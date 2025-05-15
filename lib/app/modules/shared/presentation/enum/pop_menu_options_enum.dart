enum PopMenuOptionsTypeEnum {
  favorite(
      value: "favorite",
      text: "Favorite",
      inverseText: "Unfavorite",
      tagText: "Favorited"),
  download(
      value: "download",
      text: "Download",
      inverseText: "Undownload",
      tagText: "Downloaded");

  final String value;
  final String text;
  final String inverseText;
  final String tagText;

  const PopMenuOptionsTypeEnum(
      {required this.value,
      required this.text,
      required this.inverseText,
      required this.tagText});

  static Map<String, PopMenuOptionsTypeEnum> get fromString => {
        'favorite': PopMenuOptionsTypeEnum.favorite,
        'download': PopMenuOptionsTypeEnum.download
      };
}
