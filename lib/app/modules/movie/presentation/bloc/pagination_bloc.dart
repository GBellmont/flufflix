import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flufflix/app/core/response/responses.dart';
import 'package:flufflix/app/modules/movie/data/repository/repositories.dart';
import 'package:flufflix/app/modules/movie/domain/interface/interfaces.dart';
import 'package:flufflix/app/modules/movie/presentation/enum/enums.dart';
import 'package:flufflix/app/modules/movie/presentation/state/states.dart';
import 'package:flufflix/app/modules/movie/presentation/event/events.dart';

class PaginationBloc extends Bloc<PaginationEvent, PaginationState> {
  final MovieRepositoryImpl movieRepositoryImpl;

  late final Future<AppResponse<PaginationListInterface>> Function({int? page})
      _getPaginationList;

  PaginationBloc({required this.movieRepositoryImpl})
      : super(PaginationInitialState()) {
    on<FetchPaginationListEvent>(_fecthList);
  }

  void init(PaginationListTypeEnum type) {
    switch (type) {
      case PaginationListTypeEnum.topRatedMovies:
        _getPaginationList = movieRepositoryImpl.getTopRatedMovies;
      case PaginationListTypeEnum.popularMovies:
        _getPaginationList = movieRepositoryImpl.getPopularMovies;
    }
  }

  Future<void> _fecthList(FetchPaginationListEvent event, Emitter emit) async {
    emit(PaginationLoadingState());

    final listResponse = await _getPaginationList(page: event.page);

    listResponse.hasError
        ? emit(PaginationErrorState(pageToRetrie: event.page))
        : emit(PaginationSuccessState(
            data: listResponse.success!.toPaginationListContract()));
  }
}
