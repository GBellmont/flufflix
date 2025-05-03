sealed class PaginationState {}

class PaginationInitialState extends PaginationState {}

class PaginationLoadingState extends PaginationState {}

class PaginationSuccessState<T> extends PaginationState {
  final T data;

  PaginationSuccessState({required this.data});
}

class PaginationErrorState extends PaginationState {
  final int pageToRetrie;

  PaginationErrorState({required this.pageToRetrie});
}
