import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flufflix/core/states/index.dart';
import 'package:flufflix/core/events/index.dart';

class PaginationBloc<T> extends Bloc<PaginationEvent, PaginationState> {
  final Future<T> Function({int? page}) getPaginationList;

  PaginationBloc({required this.getPaginationList})
      : super(PaginationInitialState()) {
    on<FetchPaginationListEvent>(_fecthList);
  }

  Future<void> _fecthList(FetchPaginationListEvent event, Emitter emit) async {
    emit(PaginationLoadingState());

    try {
      final listResponse = await getPaginationList(page: event.page);

      emit(PaginationSuccessState<T>(data: listResponse));
    } catch (e) {
      emit(PaginationErrorState(pageToRetrie: event.page));
    }
  }
}
