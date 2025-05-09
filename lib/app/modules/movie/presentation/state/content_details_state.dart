import 'package:flufflix/app/modules/movie/domain/contract/contracts.dart';

sealed class ContentDetailsState {}

class ContentInitialState extends ContentDetailsState {}

class ContentLoadingState extends ContentDetailsState {}

class ContentErrorState extends ContentDetailsState {}

class ContentSuccessState extends ContentDetailsState {
  final ContentDetailsContract data;

  ContentSuccessState({required this.data});
}
