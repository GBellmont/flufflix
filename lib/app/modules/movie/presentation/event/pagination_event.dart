sealed class PaginationEvent {}

class FetchPaginationListEvent extends PaginationEvent {
  final int page;

  FetchPaginationListEvent({required this.page});
}
