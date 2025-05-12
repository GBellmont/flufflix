import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

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
const String seasonId = '456';

void main() {
  late final MovieRepositoryImpl movieRepositoryImpl;
  late final SerieRepositoryImpl serieRepositoryImpl;

  setUpAll(() {
    movieRepositoryImpl = MockMovieRepositoryImpl();
    serieRepositoryImpl = MockSerieRepositoryImpl();
  });

  group('ContentListBlocTest', () {
    final localContent = MoviesModelFactory.getMovieTrailersModel()
        .toListContentListItemContract();

    group('Success With Local Content', () {
      blocTest<ContentListBloc, ContentListState>(
        'emite [ContentDetailsSuccessState] ao receber FecthContentListData com localContent',
        build: () {
          return ContentListBloc(
              movieRepositoryImpl: movieRepositoryImpl,
              serieRepositoryImpl: serieRepositoryImpl);
        },
        act: (bloc) =>
            bloc.add(FecthContentListData(id: id, localContent: localContent)),
        expect: () {
          verifyNever(() => movieRepositoryImpl.getMovieTrailers(id));

          return [
            ContentListLoadingState(),
            ContentListSuccessState(contentList: localContent)
          ];
        },
      );
    });

    group('MovieTrailers', () {
      blocTest<ContentListBloc, ContentListState>(
        'emite [ContentDetailsSuccessState] ao receber FecthContentListData',
        build: () {
          return ContentListBloc(
              movieRepositoryImpl: movieRepositoryImpl,
              serieRepositoryImpl: serieRepositoryImpl);
        },
        act: (bloc) {
          when(() => movieRepositoryImpl.getMovieTrailers(id)).thenAnswer(
              (_) async => AppResponse(
                  success: MoviesModelFactory.getMovieTrailersModel()));

          bloc.add(FecthContentListData(
              id: id,
              localContent: [],
              type: ContentListFetchTypeEnum.movieTrailers));
        },
        expect: () {
          verify(() => movieRepositoryImpl.getMovieTrailers(id)).called(1);

          return [
            ContentListLoadingState(),
            ContentListSuccessState(
                contentList: MoviesModelFactory.getMovieTrailersModel()
                    .toListContentListItemContract())
          ];
        },
      );

      blocTest<ContentListBloc, ContentListState>(
        'emite [ContentDetailsErrorState] ao receber GetContentEvent com message',
        build: () {
          when(() => movieRepositoryImpl.getMovieTrailers(id)).thenAnswer(
              (_) async => AppResponse(
                  error: NetworkError(
                      stackTrace: StackTrace.current,
                      message: 'Error With Message')));

          return ContentListBloc(
              movieRepositoryImpl: movieRepositoryImpl,
              serieRepositoryImpl: serieRepositoryImpl);
        },
        act: (bloc) => bloc.add(FecthContentListData(
            id: id,
            localContent: [],
            type: ContentListFetchTypeEnum.movieTrailers)),
        expect: () {
          verify(() => movieRepositoryImpl.getMovieTrailers(id)).called(1);

          return [
            ContentListLoadingState(),
            ContentListErrorState(message: 'Error With Message')
          ];
        },
      );

      blocTest<ContentListBloc, ContentListState>(
        'emite [ContentDetailsErrorState] ao receber GetContentEvent com message padrão',
        build: () {
          when(() => movieRepositoryImpl.getMovieTrailers(id)).thenAnswer(
              (_) async =>
                  AppResponse(error: AppError(stackTrace: StackTrace.current)));

          return ContentListBloc(
              movieRepositoryImpl: movieRepositoryImpl,
              serieRepositoryImpl: serieRepositoryImpl);
        },
        act: (bloc) => bloc.add(FecthContentListData(
            id: id,
            localContent: [],
            type: ContentListFetchTypeEnum.movieTrailers)),
        expect: () {
          verify(() => movieRepositoryImpl.getMovieTrailers(id)).called(1);

          return [
            ContentListLoadingState(),
            ContentListErrorState(message: 'Unexpected Error')
          ];
        },
      );
    });

    group('SerieTrailers', () {
      blocTest<ContentListBloc, ContentListState>(
        'emite [ContentDetailsSuccessState] ao receber FecthContentListData',
        build: () {
          return ContentListBloc(
              movieRepositoryImpl: movieRepositoryImpl,
              serieRepositoryImpl: serieRepositoryImpl);
        },
        act: (bloc) {
          when(() => serieRepositoryImpl.getSerieTrailers(id)).thenAnswer(
              (_) async => AppResponse(
                  success: SeriesModelFactory.getSerieTrailersModel()));

          bloc.add(FecthContentListData(
              id: id,
              localContent: [],
              type: ContentListFetchTypeEnum.serieTrailers));
        },
        expect: () {
          verify(() => serieRepositoryImpl.getSerieTrailers(id)).called(1);

          return [
            ContentListLoadingState(),
            ContentListSuccessState(
                contentList: SeriesModelFactory.getSerieTrailersModel()
                    .toListContentListItemContract())
          ];
        },
      );

      blocTest<ContentListBloc, ContentListState>(
        'emite [ContentDetailsErrorState] ao receber GetContentEvent com message',
        build: () {
          when(() => serieRepositoryImpl.getSerieTrailers(id)).thenAnswer(
              (_) async => AppResponse(
                  error: NetworkError(
                      stackTrace: StackTrace.current,
                      message: 'Error With Message')));

          return ContentListBloc(
              movieRepositoryImpl: movieRepositoryImpl,
              serieRepositoryImpl: serieRepositoryImpl);
        },
        act: (bloc) => bloc.add(FecthContentListData(
            id: id,
            localContent: [],
            type: ContentListFetchTypeEnum.serieTrailers)),
        expect: () {
          verify(() => serieRepositoryImpl.getSerieTrailers(id)).called(1);

          return [
            ContentListLoadingState(),
            ContentListErrorState(message: 'Error With Message')
          ];
        },
      );

      blocTest<ContentListBloc, ContentListState>(
        'emite [ContentDetailsErrorState] ao receber GetContentEvent com message padrão',
        build: () {
          when(() => serieRepositoryImpl.getSerieTrailers(id)).thenAnswer(
              (_) async =>
                  AppResponse(error: AppError(stackTrace: StackTrace.current)));

          return ContentListBloc(
              movieRepositoryImpl: movieRepositoryImpl,
              serieRepositoryImpl: serieRepositoryImpl);
        },
        act: (bloc) => bloc.add(FecthContentListData(
            id: id,
            localContent: [],
            type: ContentListFetchTypeEnum.serieTrailers)),
        expect: () {
          verify(() => serieRepositoryImpl.getSerieTrailers(id)).called(1);

          return [
            ContentListLoadingState(),
            ContentListErrorState(message: 'Unexpected Error')
          ];
        },
      );
    });

    group('SerieSeason', () {
      blocTest<ContentListBloc, ContentListState>(
        'emite [ContentDetailsSuccessState] ao receber FecthContentListData',
        build: () {
          return ContentListBloc(
              movieRepositoryImpl: movieRepositoryImpl,
              serieRepositoryImpl: serieRepositoryImpl);
        },
        act: (bloc) {
          when(() => serieRepositoryImpl.getSerieSeason(id, seasonId))
              .thenAnswer((_) async => AppResponse(
                  success: SeriesModelFactory.getSerieSeasonModel()));

          bloc.add(FecthContentListData(
              id: id,
              localContent: [],
              seasonId: seasonId,
              type: ContentListFetchTypeEnum.serieSeason));
        },
        expect: () {
          verify(() => serieRepositoryImpl.getSerieSeason(id, seasonId))
              .called(1);

          return [
            ContentListLoadingState(),
            ContentListSuccessState(
                contentList: SeriesModelFactory.getSerieSeasonModel()
                    .toListContentListItemContract())
          ];
        },
      );

      blocTest<ContentListBloc, ContentListState>(
        'emite [ContentDetailsErrorState] ao receber GetContentEvent com message',
        build: () {
          when(() => serieRepositoryImpl.getSerieSeason(id, seasonId))
              .thenAnswer((_) async => AppResponse(
                  error: NetworkError(
                      stackTrace: StackTrace.current,
                      message: 'Error With Message')));

          return ContentListBloc(
              movieRepositoryImpl: movieRepositoryImpl,
              serieRepositoryImpl: serieRepositoryImpl);
        },
        act: (bloc) => bloc.add(FecthContentListData(
            id: id,
            localContent: [],
            seasonId: seasonId,
            type: ContentListFetchTypeEnum.serieSeason)),
        expect: () {
          verify(() => serieRepositoryImpl.getSerieSeason(id, seasonId))
              .called(1);

          return [
            ContentListLoadingState(),
            ContentListErrorState(message: 'Error With Message')
          ];
        },
      );

      blocTest<ContentListBloc, ContentListState>(
        'emite [ContentDetailsErrorState] ao receber GetContentEvent com message padrão',
        build: () {
          when(() => serieRepositoryImpl.getSerieSeason(id, seasonId))
              .thenAnswer((_) async =>
                  AppResponse(error: AppError(stackTrace: StackTrace.current)));

          return ContentListBloc(
              movieRepositoryImpl: movieRepositoryImpl,
              serieRepositoryImpl: serieRepositoryImpl);
        },
        act: (bloc) => bloc.add(FecthContentListData(
            id: id,
            localContent: [],
            seasonId: seasonId,
            type: ContentListFetchTypeEnum.serieSeason)),
        expect: () {
          verify(() => serieRepositoryImpl.getSerieSeason(id, seasonId))
              .called(1);

          return [
            ContentListLoadingState(),
            ContentListErrorState(message: 'Unexpected Error')
          ];
        },
      );
    });
  });
}
