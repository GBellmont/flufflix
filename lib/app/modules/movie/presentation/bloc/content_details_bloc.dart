import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flufflix/app/modules/movie/data/repositories/repositories.dart';
import 'package:flufflix/app/modules/movie/presentation/event/events.dart';
import 'package:flufflix/app/modules/movie/presentation/state/states.dart';

class ContentDetailsBloc
    extends Bloc<ContentDetailsEvent, ContentDetailsState> {
  final MovieRepositoryImpl movieRepositoryImpl;

  ContentDetailsBloc({required this.movieRepositoryImpl})
      : super(ContentInitialState()) {
    on<GetMovieContentEvent>(_fetchMovieDetails);
  }

  Future<void> _fetchMovieDetails(
      GetMovieContentEvent event, Emitter emit) async {
    emit(ContentLoadingState());

    final response =
        await movieRepositoryImpl.getMovieDetailsResponse(event.contentId);

    response.hasError
        ? emit(ContentErrorState())
        : emit(ContentSuccessState(
            data: response.success!.toContentDetailsContract()));
  }
}
