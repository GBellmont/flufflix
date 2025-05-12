enum ContentTypeEnum {
  movie,
  serie;

  static Map<String, ContentTypeEnum> get fromString =>
      {'movie': ContentTypeEnum.movie, 'serie': ContentTypeEnum.serie};
}
