import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flufflix/app/core/response/responses.dart';

import 'package:flufflix/app/modules/content/data/repository/repositories.dart';
import 'package:flufflix/app/modules/content/domain/interface/interfaces.dart';
import 'package:flufflix/app/modules/content/presentation/enum/enums.dart';
import 'package:flufflix/app/modules/content/presentation/state/states.dart';
import 'package:flufflix/app/modules/content/presentation/event/events.dart';

class PaginationBloc extends Bloc<PaginationEvent, PaginationState> {
  final MovieRepositoryImpl movieRepositoryImpl;
  final SerieRepositoryImpl serieRepositoryImpl;

  late final Future<AppResponse<PaginationListInterface>> Function({int? page})
      _getPaginationList;

  PaginationBloc(
      {required this.movieRepositoryImpl, required this.serieRepositoryImpl})
      : super(PaginationInitialState()) {
    on<FetchPaginationListEvent>(_fecthList);
  }

  void init(PaginationListTypeEnum type) {
    switch (type) {
      case PaginationListTypeEnum.topRatedMovies:
        _getPaginationList = movieRepositoryImpl.getTopRatedMovies;
      case PaginationListTypeEnum.popularMovies:
        _getPaginationList = movieRepositoryImpl.getPopularMovies;
      case PaginationListTypeEnum.topRatedSeries:
        _getPaginationList = serieRepositoryImpl.getTopRatedSeries;
      case PaginationListTypeEnum.popularSeries:
        _getPaginationList = serieRepositoryImpl.getPopularSeries;
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
