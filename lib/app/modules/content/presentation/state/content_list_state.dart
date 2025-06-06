import 'package:equatable/equatable.dart';

import 'package:flufflix/app/modules/content/domain/contract/contracts.dart';

sealed class ContentListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ContentListInitialState extends ContentListState {}

class ContentListLoadingState extends ContentListState {}

class ContentListSuccessState extends ContentListState {
  final List<ContentListItemContract> contentList;

  ContentListSuccessState({required this.contentList});

  @override
  List<Object?> get props => contentList.map((item) => item.title).toList();
}

class ContentListErrorState extends ContentListState {
  final String message;

  ContentListErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
