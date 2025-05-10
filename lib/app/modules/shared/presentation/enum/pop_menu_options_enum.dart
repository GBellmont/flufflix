enum PopMenuOptionsTypeEnum {
  favorite(value: "favorite", text: "Favorite", inverseText: "Unfavorite"),
  download(value: "download", text: "Download", inverseText: "Undownload");

  final String value;
  final String text;
  final String inverseText;

  const PopMenuOptionsTypeEnum(
      {required this.value, required this.text, required this.inverseText});

  static Map<String, PopMenuOptionsTypeEnum> get fromString => {
        'favorite': PopMenuOptionsTypeEnum.favorite,
        'download': PopMenuOptionsTypeEnum.download
      };
}
