import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flufflix/app/core/error/errors.dart';
import 'package:flufflix/app/core/response/responses.dart';

import 'package:flufflix/app/modules/content/data/repository/repositories.dart';
import 'package:flufflix/app/modules/content/presentation/enum/enums.dart';
import 'package:flufflix/app/modules/content/presentation/event/events.dart';
import 'package:flufflix/app/modules/content/presentation/state/states.dart';
import 'package:flufflix/app/modules/content/presentation/bloc/blocs.dart';

import '../../../../../mock/factory/factories.dart';
import '../../../../../mock/mocks.dart';

const String id = '123';

void main() {
  late final MovieRepositoryImpl movieRepositoryImpl;
  late final SerieRepositoryImpl serieRepositoryImpl;

  setUpAll(() {
    movieRepositoryImpl = MockMovieRepositoryImpl();
    serieRepositoryImpl = MockSerieRepositoryImpl();
  });

  group('ContentDetailsBlocTest', () {
    group('TopRatedMovies', () {
      blocTest<PaginationBloc, PaginationState>(
        'emite [PaginationSuccessState] ao receber FetchPaginationListEvent',
        build: () {
          when(() => movieRepositoryImpl.getTopRatedMovies(page: 1)).thenAnswer(
              (_) async =>
                  AppResponse(success: MoviesModelFactory.getMoviesModel()));

          return PaginationBloc(
              movieRepositoryImpl: movieRepositoryImpl,
              serieRepositoryImpl: serieRepositoryImpl)
            ..init(PaginationListTypeEnum.topRatedMovies);
        },
        act: (bloc) => bloc.add(FetchPaginationListEvent(page: 1)),
        expect: () {
          verify(() => movieRepositoryImpl.getTopRatedMovies(page: 1))
              .called(1);

          return [
            PaginationLoadingState(),
            PaginationSuccessState(
                data: MoviesModelFactory.getMoviesModel()
                    .toPaginationListContract())
          ];
        },
      );

      blocTest<PaginationBloc, PaginationState>(
        'emite [PaginationErrorState] ao receber FetchPaginationListEvent',
        build: () {
          when(() => movieRepositoryImpl.getTopRatedMovies(page: 1)).thenAnswer(
              (_) async =>
                  AppResponse(error: AppError(stackTrace: StackTrace.current)));

          return PaginationBloc(
              movieRepositoryImpl: movieRepositoryImpl,
              serieRepositoryImpl: serieRepositoryImpl)
            ..init(PaginationListTypeEnum.topRatedMovies);
        },
        act: (bloc) => bloc.add(FetchPaginationListEvent(page: 1)),
        expect: () {
          verify(() => movieRepositoryImpl.getTopRatedMovies(page: 1))
              .called(1);

          return [
            PaginationLoadingState(),
            PaginationErrorState(pageToRetrie: 1)
          ];
        },
      );
    });

    group('PopularMovies', () {
      blocTest<PaginationBloc, PaginationState>(
        'emite [PaginationSuccessState] ao receber FetchPaginationListEvent',
        build: () {
          when(() => movieRepositoryImpl.getPopularMovies(page: 1)).thenAnswer(
              (_) async =>
                  AppResponse(success: MoviesModelFactory.getMoviesModel()));

          return PaginationBloc(
              movieRepositoryImpl: movieRepositoryImpl,
              serieRepositoryImpl: serieRepositoryImpl)
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
        'emite [PaginationErrorState] ao receber FetchPaginationListEvent',
        build: () {
          when(() => movieRepositoryImpl.getPopularMovies(page: 1)).thenAnswer(
              (_) async =>
                  AppResponse(error: AppError(stackTrace: StackTrace.current)));

          return PaginationBloc(
              movieRepositoryImpl: movieRepositoryImpl,
              serieRepositoryImpl: serieRepositoryImpl)
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

    group('TopRatedSeries', () {
      blocTest<PaginationBloc, PaginationState>(
        'emite [PaginationSuccessState] ao receber FetchPaginationListEvent',
        build: () {
          when(() => serieRepositoryImpl.getTopRatedSeries(page: 1)).thenAnswer(
              (_) async =>
                  AppResponse(success: SeriesModelFactory.getSeriesModel()));

          return PaginationBloc(
              movieRepositoryImpl: movieRepositoryImpl,
              serieRepositoryImpl: serieRepositoryImpl)
            ..init(PaginationListTypeEnum.topRatedSeries);
        },
        act: (bloc) => bloc.add(FetchPaginationListEvent(page: 1)),
        expect: () {
          verify(() => serieRepositoryImpl.getTopRatedSeries(page: 1))
              .called(1);

          return [
            PaginationLoadingState(),
            PaginationSuccessState(
                data: SeriesModelFactory.getSeriesModel()
                    .toPaginationListContract())
          ];
        },
      );

      blocTest<PaginationBloc, PaginationState>(
        'emite [PaginationErrorState] ao receber FetchPaginationListEvent',
        build: () {
          when(() => serieRepositoryImpl.getTopRatedSeries(page: 1)).thenAnswer(
              (_) async =>
                  AppResponse(error: AppError(stackTrace: StackTrace.current)));

          return PaginationBloc(
              movieRepositoryImpl: movieRepositoryImpl,
              serieRepositoryImpl: serieRepositoryImpl)
            ..init(PaginationListTypeEnum.topRatedSeries);
        },
        act: (bloc) => bloc.add(FetchPaginationListEvent(page: 1)),
        expect: () {
          verify(() => serieRepositoryImpl.getTopRatedSeries(page: 1))
              .called(1);

          return [
            PaginationLoadingState(),
            PaginationErrorState(pageToRetrie: 1)
          ];
        },
      );
    });

    group('PopularSeries', () {
      blocTest<PaginationBloc, PaginationState>(
        'emite [PaginationSuccessState] ao receber FetchPaginationListEvent',
        build: () {
          when(() => serieRepositoryImpl.getPopularSeries(page: 1)).thenAnswer(
              (_) async =>
                  AppResponse(success: SeriesModelFactory.getSeriesModel()));

          return PaginationBloc(
              movieRepositoryImpl: movieRepositoryImpl,
              serieRepositoryImpl: serieRepositoryImpl)
            ..init(PaginationListTypeEnum.popularSeries);
        },
        act: (bloc) => bloc.add(FetchPaginationListEvent(page: 1)),
        expect: () {
          verify(() => serieRepositoryImpl.getPopularSeries(page: 1)).called(1);

          return [
            PaginationLoadingState(),
            PaginationSuccessState(
                data: SeriesModelFactory.getSeriesModel()
                    .toPaginationListContract())
          ];
        },
      );

      blocTest<PaginationBloc, PaginationState>(
        'emite [PaginationErrorState] ao receber FetchPaginationListEvent',
        build: () {
          when(() => serieRepositoryImpl.getPopularSeries(page: 1)).thenAnswer(
              (_) async =>
                  AppResponse(error: AppError(stackTrace: StackTrace.current)));

          return PaginationBloc(
              movieRepositoryImpl: movieRepositoryImpl,
              serieRepositoryImpl: serieRepositoryImpl)
            ..init(PaginationListTypeEnum.popularSeries);
        },
        act: (bloc) => bloc.add(FetchPaginationListEvent(page: 1)),
        expect: () {
          verify(() => serieRepositoryImpl.getPopularSeries(page: 1)).called(1);

          return [
            PaginationLoadingState(),
            PaginationErrorState(pageToRetrie: 1)
          ];
        },
      );
    });
  });
}
