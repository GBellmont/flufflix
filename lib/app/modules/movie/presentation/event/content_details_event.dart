sealed class ContentDetailsEvent {
  final String contentId;

  const ContentDetailsEvent({required this.contentId});
}

class GetMovieContentEvent extends ContentDetailsEvent {
  GetMovieContentEvent({required super.contentId});
}
