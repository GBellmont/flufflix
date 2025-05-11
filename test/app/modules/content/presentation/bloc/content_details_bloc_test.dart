import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flufflix/app/core/error/errors.dart';
import 'package:flufflix/app/core/response/responses.dart';

import 'package:flufflix/app/modules/content/data/repository/repositories.dart';
import 'package:flufflix/app/modules/content/presentation/enum/enums.dart';
import 'package:flufflix/app/modules/content/presentation/event/content_details_event.dart';
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
    group('Movie', () {
      blocTest<ContentDetailsBloc, ContentDetailsState>(
        'emite [ContentDetailsSuccessState] ao receber GetContentEvent',
        build: () {
          when(() => movieRepositoryImpl.getMovieDetails(id)).thenAnswer(
              (_) async => AppResponse(
                  success: MoviesModelFactory.getMovieDetailsModel()));

          return ContentDetailsBloc(
              movieRepositoryImpl: movieRepositoryImpl,
              serieRepositoryImpl: serieRepositoryImpl);
        },
        act: (bloc) => bloc.add(
            GetContentEvent(contentId: '123', type: ContentTypeEnum.movie)),
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
        'emite [ContentDetailsErrorState] ao receber GetContentEvent com message',
        build: () {
          when(() => movieRepositoryImpl.getMovieDetails(id)).thenAnswer(
              (_) async => AppResponse(
                  error: NetworkError(
                      stackTrace: StackTrace.current,
                      message: 'ErrorWithMessage')));

          return ContentDetailsBloc(
              movieRepositoryImpl: movieRepositoryImpl,
              serieRepositoryImpl: serieRepositoryImpl);
        },
        act: (bloc) => bloc.add(
            GetContentEvent(contentId: '123', type: ContentTypeEnum.movie)),
        expect: () {
          verify(() => movieRepositoryImpl.getMovieDetails(id)).called(1);

          return [
            ContentDetailsLoadingState(),
            ContentDetailsErrorState(message: 'ErrorWithMessage')
          ];
        },
      );

      blocTest<ContentDetailsBloc, ContentDetailsState>(
        'emite [ContentDetailsErrorState] ao receber GetContentEvent com message padrão',
        build: () {
          when(() => movieRepositoryImpl.getMovieDetails(id))
              .thenAnswer((_) async => AppResponse(
                      error: NetworkError(
                    stackTrace: StackTrace.current,
                  )));

          return ContentDetailsBloc(
              movieRepositoryImpl: movieRepositoryImpl,
              serieRepositoryImpl: serieRepositoryImpl);
        },
        act: (bloc) => bloc.add(
            GetContentEvent(contentId: '123', type: ContentTypeEnum.movie)),
        expect: () {
          verify(() => movieRepositoryImpl.getMovieDetails(id)).called(1);

          return [
            ContentDetailsLoadingState(),
            ContentDetailsErrorState(message: 'Unexpected Error')
          ];
        },
      );
    });

    group('Serie', () {
      blocTest<ContentDetailsBloc, ContentDetailsState>(
        'emite [ContentDetailsSuccessState] ao receber GetContentEvent',
        build: () {
          when(() => serieRepositoryImpl.getSerieDetails(id)).thenAnswer(
              (_) async => AppResponse(
                  success: SeriesModelFactory.getSerieDetailsModel()));

          return ContentDetailsBloc(
              movieRepositoryImpl: movieRepositoryImpl,
              serieRepositoryImpl: serieRepositoryImpl);
        },
        act: (bloc) => bloc.add(
            GetContentEvent(contentId: '123', type: ContentTypeEnum.serie)),
        expect: () {
          verify(() => serieRepositoryImpl.getSerieDetails(id)).called(1);

          return [
            ContentDetailsLoadingState(),
            ContentDetailsSuccessState(
                data: SeriesModelFactory.getSerieDetailsModel()
                    .toContentDetailsContract())
          ];
        },
      );

      blocTest<ContentDetailsBloc, ContentDetailsState>(
        'emite [ContentDetailsErrorState] ao receber GetContentEvent com message',
        build: () {
          when(() => serieRepositoryImpl.getSerieDetails(id)).thenAnswer(
              (_) async => AppResponse(
                  error: NetworkError(
                      stackTrace: StackTrace.current,
                      message: 'ErrorWithMessage')));

          return ContentDetailsBloc(
              movieRepositoryImpl: movieRepositoryImpl,
              serieRepositoryImpl: serieRepositoryImpl);
        },
        act: (bloc) => bloc.add(
            GetContentEvent(contentId: '123', type: ContentTypeEnum.serie)),
        expect: () {
          verify(() => serieRepositoryImpl.getSerieDetails(id)).called(1);

          return [
            ContentDetailsLoadingState(),
            ContentDetailsErrorState(message: 'ErrorWithMessage')
          ];
        },
      );

      blocTest<ContentDetailsBloc, ContentDetailsState>(
        'emite [ContentDetailsErrorState] ao receber GetContentEvent com message padrão',
        build: () {
          when(() => serieRepositoryImpl.getSerieDetails(id))
              .thenAnswer((_) async => AppResponse(
                      error: NetworkError(
                    stackTrace: StackTrace.current,
                  )));

          return ContentDetailsBloc(
              movieRepositoryImpl: movieRepositoryImpl,
              serieRepositoryImpl: serieRepositoryImpl);
        },
        act: (bloc) => bloc.add(
            GetContentEvent(contentId: '123', type: ContentTypeEnum.serie)),
        expect: () {
          verify(() => serieRepositoryImpl.getSerieDetails(id)).called(1);

          return [
            ContentDetailsLoadingState(),
            ContentDetailsErrorState(message: 'Unexpected Error')
          ];
        },
      );
    });
  });
}
