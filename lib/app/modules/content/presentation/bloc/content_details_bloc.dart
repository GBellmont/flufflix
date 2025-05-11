import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flufflix/app/core/response/responses.dart';

import 'package:flufflix/app/modules/content/domain/interface/interfaces.dart';
import 'package:flufflix/app/modules/content/presentation/enum/enums.dart';
import 'package:flufflix/app/modules/content/data/repository/repositories.dart';
import 'package:flufflix/app/modules/content/presentation/event/events.dart';
import 'package:flufflix/app/modules/content/presentation/state/states.dart';

class ContentDetailsBloc
    extends Bloc<ContentDetailsEvent, ContentDetailsState> {
  final MovieRepositoryImpl movieRepositoryImpl;
  final SerieRepositoryImpl serieRepositoryImpl;

  ContentDetailsBloc(
      {required this.movieRepositoryImpl, required this.serieRepositoryImpl})
      : super(ContentDetailsInitialState()) {
    on<GetContentEvent>(_fetchMovieDetails);
  }

  Future<AppResponse<ContentDetailsInterface>> _getContent(
      ContentTypeEnum type, String id) async {
    switch (type) {
      case ContentTypeEnum.movie:
        return await movieRepositoryImpl.getMovieDetails(id);
      case ContentTypeEnum.serie:
        return await serieRepositoryImpl.getSerieDetails(id);
    }
  }

  Future<void> _fetchMovieDetails(GetContentEvent event, Emitter emit) async {
    emit(ContentDetailsLoadingState());

    final response = await _getContent(event.type, event.contentId);

    response.hasError
        ? emit(ContentDetailsErrorState(
            message: response.error?.message ?? 'Unexpected Error'))
        : emit(ContentDetailsSuccessState(
            data: response.success!.toContentDetailsContract()));
  }
}
