import 'package:bloc_test/bloc_test.dart';
import 'package:flufflix/app/core/error/errors.dart';
import 'package:flufflix/app/core/response/responses.dart';
import 'package:flufflix/app/modules/movie/data/repository/repositories.dart';
import 'package:flufflix/app/modules/movie/presentation/event/content_details_event.dart';
import 'package:flufflix/app/modules/movie/presentation/state/states.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flufflix/app/modules/movie/presentation/bloc/blocs.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mock/factory/factories.dart';
import '../../../../../mock/mocks.dart';

const String id = '123';

void main() {
  late final MovieRepositoryImpl movieRepositoryImpl;

  setUpAll(() {
    movieRepositoryImpl = MockMovieRepositoryImpl();
  });

  group('ContentDetailsBlocTest', () {
    blocTest<ContentDetailsBloc, ContentDetailsState>(
      'emite [ContentDetailsSuccessState] ao receber GetMovieContentEvent',
      build: () {
        when(() => movieRepositoryImpl.getMovieDetails(id)).thenAnswer(
            (_) async => AppResponse(
                success: MoviesModelFactory.getMovieDetailsModel()));

        return ContentDetailsBloc(movieRepositoryImpl: movieRepositoryImpl);
      },
      act: (bloc) => bloc.add(GetMovieContentEvent(contentId: '123')),
      expect: () {
        verify(() => movieRepositoryImpl.getMovieDetails(id)).called(1);

        return [
          ContentDetailsLoadingState(),
          ContentDetailsSuccessState(
              data: MoviesModelFactory.getMovieDetailsModel()
                  .toContentDetailsContract())
        ];
      },
    );

    blocTest<ContentDetailsBloc, ContentDetailsState>(
      'emite [ContentDetailsErrorState] ao receber GetMovieContentEvent',
      build: () {
        when(() => movieRepositoryImpl.getMovieDetails(id)).thenAnswer(
            (_) async =>
                AppResponse(error: AppError(stackTrace: StackTrace.current)));

        return ContentDetailsBloc(movieRepositoryImpl: movieRepositoryImpl);
      },
      act: (bloc) => bloc.add(GetMovieContentEvent(contentId: '123')),
      expect: () {
        verify(() => movieRepositoryImpl.getMovieDetails(id)).called(1);

        return [ContentDetailsLoadingState(), ContentDetailsErrorState()];
      },
    );
  });
}
