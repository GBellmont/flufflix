sealed class ContentEvent {
  final String contentId;

  const ContentEvent({required this.contentId});
}

class GetMovieContentEvent extends ContentEvent {
  GetMovieContentEvent({required super.contentId});
}
