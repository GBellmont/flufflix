import 'package:flufflix/app/modules/movie/domain/contract/contracts.dart';

sealed class PaginationState {}

class PaginationInitialState extends PaginationState {}

class PaginationLoadingState extends PaginationState {}

class PaginationSuccessState extends PaginationState {
  final PaginationListContract data;

  PaginationSuccessState({required this.data});
}

class PaginationErrorState extends PaginationState {
  final int pageToRetrie;

  PaginationErrorState({required this.pageToRetrie});
}
