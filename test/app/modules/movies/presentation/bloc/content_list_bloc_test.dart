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

  group('ContentListBlocTest', () {
    final localContent = MoviesModelFactory.getMovieTrailersModel()
        .toListContentListItemContract();

    blocTest<ContentListBloc, ContentListState>(
      'emite [ContentDetailsSuccessState] ao receber FecthContentListData com localContent',
      build: () {
        return ContentListBloc(movieRepositoryImpl: movieRepositoryImpl);
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

    blocTest<ContentListBloc, ContentListState>(
      'emite [ContentDetailsSuccessState] ao receber FecthContentListData',
      build: () {
        return ContentListBloc(movieRepositoryImpl: movieRepositoryImpl);
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
      'emite [ContentDetailsErrorState] ao receber GetMovieContentEvent com message',
      build: () {
        when(() => movieRepositoryImpl.getMovieTrailers(id)).thenAnswer(
            (_) async => AppResponse(
                error: NetworkError(
                    stackTrace: StackTrace.current,
                    message: 'Error With Message')));

        return ContentListBloc(movieRepositoryImpl: movieRepositoryImpl);
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
      'emite [ContentDetailsErrorState] ao receber GetMovieContentEvent com message padrão',
      build: () {
        when(() => movieRepositoryImpl.getMovieTrailers(id)).thenAnswer(
            (_) async =>
                AppResponse(error: AppError(stackTrace: StackTrace.current)));

        return ContentListBloc(movieRepositoryImpl: movieRepositoryImpl);
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
}
