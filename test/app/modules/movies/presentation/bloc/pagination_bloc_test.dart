import 'package:bloc_test/bloc_test.dart';
import 'package:flufflix/app/core/error/errors.dart';
import 'package:flufflix/app/core/response/responses.dart';
import 'package:flufflix/app/modules/movie/data/repository/repositories.dart';
import 'package:flufflix/app/modules/movie/presentation/enum/enums.dart';
import 'package:flufflix/app/modules/movie/presentation/event/events.dart';
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
    blocTest<PaginationBloc, PaginationState>(
      'emite [PaginationSuccessState] ao receber FetchPaginationListEvent com init(topRatedMovies)',
      build: () {
        when(() => movieRepositoryImpl.getTopRatedMovies(page: 1)).thenAnswer(
            (_) async =>
                AppResponse(success: MoviesModelFactory.getMoviesModel()));

        return PaginationBloc(movieRepositoryImpl: movieRepositoryImpl)
          ..init(PaginationListTypeEnum.topRatedMovies);
      },
      act: (bloc) => bloc.add(FetchPaginationListEvent(page: 1)),
      expect: () {
        verify(() => movieRepositoryImpl.getTopRatedMovies(page: 1)).called(1);

        return [
          PaginationLoadingState(),
          PaginationSuccessState(
              data: MoviesModelFactory.getMoviesModel()
                  .toPaginationListContract())
        ];
      },
    );

    blocTest<PaginationBloc, PaginationState>(
      'emite [PaginationErrorState] ao receber FetchPaginationListEvent com init(topRatedMovies)',
      build: () {
        when(() => movieRepositoryImpl.getTopRatedMovies(page: 1)).thenAnswer(
            (_) async =>
                AppResponse(error: AppError(stackTrace: StackTrace.current)));

        return PaginationBloc(movieRepositoryImpl: movieRepositoryImpl)
          ..init(PaginationListTypeEnum.topRatedMovies);
      },
      act: (bloc) => bloc.add(FetchPaginationListEvent(page: 1)),
      expect: () {
        verify(() => movieRepositoryImpl.getTopRatedMovies(page: 1)).called(1);

        return [
          PaginationLoadingState(),
          PaginationErrorState(pageToRetrie: 1)
        ];
      },
    );

    blocTest<PaginationBloc, PaginationState>(
      'emite [PaginationSuccessState] ao receber FetchPaginationListEvent com init(popularMovies)',
      build: () {
        when(() => movieRepositoryImpl.getPopularMovies(page: 1)).thenAnswer(
            (_) async =>
                AppResponse(success: MoviesModelFactory.getMoviesModel()));

        return PaginationBloc(movieRepositoryImpl: movieRepositoryImpl)
          ..init(PaginationListTypeEnum.popularMovies);
      },
      act: (bloc) => bloc.add(FetchPaginationListEvent(page: 1)),
      expect: () {
        verify(() => movieRepositoryImpl.getPopularMovies(page: 1)).called(1);

        return [
          PaginationLoadingState(),
          PaginationSuccessState(
              data: MoviesModelFactory.getMoviesModel()
                  .toPaginationListContract())
        ];
      },
    );

    blocTest<PaginationBloc, PaginationState>(
      'emite [PaginationErrorState] ao receber FetchPaginationListEvent com init(popularMovies)',
      build: () {
        when(() => movieRepositoryImpl.getPopularMovies(page: 1)).thenAnswer(
            (_) async =>
                AppResponse(error: AppError(stackTrace: StackTrace.current)));

        return PaginationBloc(movieRepositoryImpl: movieRepositoryImpl)
          ..init(PaginationListTypeEnum.popularMovies);
      },
      act: (bloc) => bloc.add(FetchPaginationListEvent(page: 1)),
      expect: () {
        verify(() => movieRepositoryImpl.getPopularMovies(page: 1)).called(1);

        return [
          PaginationLoadingState(),
          PaginationErrorState(pageToRetrie: 1)
        ];
      },
    );
  });
}
