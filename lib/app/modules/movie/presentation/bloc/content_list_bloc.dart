import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flufflix/app/core/response/responses.dart';

import 'package:flufflix/app/modules/movie/data/repository/repositories.dart';
import 'package:flufflix/app/modules/movie/domain/interface/interfaces.dart';
import 'package:flufflix/app/modules/movie/presentation/enum/enums.dart';
import 'package:flufflix/app/modules/movie/presentation/event/events.dart';
import 'package:flufflix/app/modules/movie/presentation/state/states.dart';

class ContentListBloc extends Bloc<ContentListEvent, ContentListState> {
  final MovieRepositoryImpl movieRepositoryImpl;

  ContentListBloc({required this.movieRepositoryImpl})
      : super(ContentListInitialState()) {
    on<FecthContentListData>(_fecthContentListData);
  }

  Future<AppResponse<ListContentListItemInterface>> Function(String id)
      _getContentFunction(ContentListFetchTypeEnum type) {
    switch (type) {
      case ContentListFetchTypeEnum.movieTrailers:
        return movieRepositoryImpl.getMovieTrailers;
    }
  }

  Future<void> _fecthContentListData(
      FecthContentListData event, Emitter emit) async {
    emit(ContentListLoadingState());

    if (event.localContent.isNotEmpty) {
      emit(ContentListSuccessState(contentList: event.localContent));
      return;
    }

    final function = _getContentFunction(event.type!);
    final response = await function(event.id);

    response.hasError
        ? emit(ContentListErrorState(
            message: response.error?.message ?? 'Unexpected Error'))
        : emit(ContentListSuccessState(
            contentList: response.success!.toListContentListItemContract()));
  }
}
