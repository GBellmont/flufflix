import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flufflix/app/core/response/responses.dart';

import 'package:flufflix/app/modules/content/data/repository/repositories.dart';
import 'package:flufflix/app/modules/content/domain/interface/interfaces.dart';
import 'package:flufflix/app/modules/content/presentation/enum/enums.dart';
import 'package:flufflix/app/modules/content/presentation/event/events.dart';
import 'package:flufflix/app/modules/content/presentation/state/states.dart';

class ContentListBloc extends Bloc<ContentListEvent, ContentListState> {
  final MovieRepositoryImpl movieRepositoryImpl;
  final SerieRepositoryImpl serieRepositoryImpl;

  ContentListBloc(
      {required this.movieRepositoryImpl, required this.serieRepositoryImpl})
      : super(ContentListInitialState()) {
    on<FecthContentListData>(_fecthContentListData);
  }

  Future<AppResponse<ListContentListItemInterface>> _getContent(
      ContentListFetchTypeEnum type, String id, String? seasonId) async {
    switch (type) {
      case ContentListFetchTypeEnum.movieTrailers:
        return await movieRepositoryImpl.getMovieTrailers(id);
      case ContentListFetchTypeEnum.serieTrailers:
        return await serieRepositoryImpl.getSerieTrailers(id);
      case ContentListFetchTypeEnum.serieSeason:
        return await serieRepositoryImpl.getSerieSeason(id, seasonId!);
    }
  }

  Future<void> _fecthContentListData(
      FecthContentListData event, Emitter emit) async {
    emit(ContentListLoadingState());

    if (event.localContent.isNotEmpty) {
      emit(ContentListSuccessState(contentList: event.localContent));
      return;
    }

    final response = await _getContent(event.type!, event.id, event.seasonId);

    response.hasError
        ? emit(ContentListErrorState(
            message: response.error?.message ?? 'Unexpected Error'))
        : emit(ContentListSuccessState(
            contentList: response.success!.toListContentListItemContract()));
  }
}
