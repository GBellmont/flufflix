import 'package:equatable/equatable.dart';

import 'package:flufflix/app/modules/content/domain/contract/contracts.dart';

sealed class StoredContentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class StoredContentInitialState extends StoredContentState {}

class StoredContentLoadingState extends StoredContentState {}

class StoredContentSuccessState extends StoredContentState {
  final List<StoredContentCardContract> list;

  StoredContentSuccessState({required this.list});

  @override
  List<Object?> get props => list.map((item) => item.id).toList();
}

class StoredContentErrorState extends StoredContentState {
  final String message;

  StoredContentErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
