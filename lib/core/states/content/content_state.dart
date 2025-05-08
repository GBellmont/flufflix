import 'package:flufflix/components/content/contract/index.dart';

sealed class ContentState {}

class ContentInitialState extends ContentState {}

class ContentLoadingState extends ContentState {}

class ContentErrorState extends ContentState {}

class ContentSuccessState extends ContentState {
  final ContentContract data;

  ContentSuccessState({required this.data});
}
