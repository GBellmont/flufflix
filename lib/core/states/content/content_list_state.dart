import 'package:flufflix/components/content/contract/index.dart';

sealed class ContentListState {}

class ContentListInitialState extends ContentListState {}

class ContentListLoadingState extends ContentListState {}

class ContentListSuccessState<T extends ContentListItemContract>
    extends ContentListState {
  final List<T> contentList;

  ContentListSuccessState({required this.contentList});
}

class ContentListErrorState extends ContentListState {}
