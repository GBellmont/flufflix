import 'package:equatable/equatable.dart';

import 'package:flufflix/app/modules/content/domain/contract/contracts.dart';

sealed class ContentDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ContentDetailsInitialState extends ContentDetailsState {}

class ContentDetailsLoadingState extends ContentDetailsState {}

class ContentDetailsErrorState extends ContentDetailsState {
  final String message;

  ContentDetailsErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class ContentDetailsSuccessState extends ContentDetailsState {
  final ContentDetailsContract data;

  ContentDetailsSuccessState({required this.data});

  @override
  List<Object?> get props => [data.id];
}
