import 'package:flufflix/app/modules/movie/domain/contract/contracts.dart';

sealed class ContentListState {}

class ContentListInitialState extends ContentListState {}

class ContentListLoadingState extends ContentListState {}

class ContentListSuccessState extends ContentListState {
  final List<ContentListItemContract> contentList;

  ContentListSuccessState({required this.contentList});
}

class ContentListErrorState extends ContentListState {}
