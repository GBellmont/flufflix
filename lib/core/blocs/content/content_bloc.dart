import 'package:flufflix/core/repositories/movie_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flufflix/core/states/index.dart';
import 'package:flufflix/core/events/index.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  final MovieRepository movieRepository;

  ContentBloc({required this.movieRepository}) : super(ContentInitialState()) {
    on<GetMovieContentEvent>(_fetchMovieDetails);
  }

  Future<void> _fetchMovieDetails(
      GetMovieContentEvent event, Emitter emit) async {
    emit(ContentLoadingState());

    try {
      final movieDetails =
          await movieRepository.getMovieDetailsResponse(event.contentId);

      emit(ContentSuccessState(data: movieDetails.toContentContract()));
    } catch (_) {
      emit(ContentErrorState());
    }
  }
}
