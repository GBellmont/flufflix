import 'package:equatable/equatable.dart';
import 'package:flufflix/app/modules/shared/domain/contract/contracts.dart';

sealed class PopMenuOptionsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PopMenuOptionsInitialState extends PopMenuOptionsState {}

class PopMenuOptionsLoadingState extends PopMenuOptionsState {}

class PopMenuOptionsSuccessState extends PopMenuOptionsState {
  final List<PopMenuVerifiedOptionContract> options;

  PopMenuOptionsSuccessState({required this.options});

  @override
  List<Object?> get props => options.map((item) => item.type.value).toList();
}

class PopMenuOptionsErrorState extends PopMenuOptionsState {
  final String message;

  PopMenuOptionsErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
