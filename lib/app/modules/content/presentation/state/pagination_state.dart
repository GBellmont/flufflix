import 'package:equatable/equatable.dart';

import 'package:flufflix/app/modules/content/domain/contract/contracts.dart';

sealed class PaginationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PaginationInitialState extends PaginationState {}

class PaginationLoadingState extends PaginationState {}

class PaginationSuccessState extends PaginationState {
  final PaginationListContract data;

  PaginationSuccessState({required this.data});

  @override
  List<Object?> get props => data.list.map((item) => item.id).toList();
}

class PaginationErrorState extends PaginationState {
  final int pageToRetrie;

  PaginationErrorState({required this.pageToRetrie});

  @override
  List<Object?> get props => [pageToRetrie];
}
