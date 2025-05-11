import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flufflix/app/modules/movie/data/repository/repositories.dart';
import 'package:flufflix/app/modules/movie/presentation/event/events.dart';
import 'package:flufflix/app/modules/movie/presentation/state/states.dart';

class ContentDetailsBloc
    extends Bloc<ContentDetailsEvent, ContentDetailsState> {
  final MovieRepositoryImpl movieRepositoryImpl;

  ContentDetailsBloc({required this.movieRepositoryImpl})
      : super(ContentDetailsInitialState()) {
    on<GetMovieContentEvent>(_fetchMovieDetails);
  }

  Future<void> _fetchMovieDetails(
      GetMovieContentEvent event, Emitter emit) async {
    emit(ContentDetailsLoadingState());

    final response = await movieRepositoryImpl.getMovieDetails(event.contentId);

    response.hasError
        ? emit(ContentDetailsErrorState(
            message: response.error?.message ?? 'Unexpected Error'))
        : emit(ContentDetailsSuccessState(
            data: response.success!.toContentDetailsContract()));
  }
}
