import 'package:bloc_test/bloc_test.dart';
import 'package:flufflix/app/modules/content/presentation/enum/enums.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flufflix/app/core/error/errors.dart';
import 'package:flufflix/app/core/response/responses.dart';

import 'package:flufflix/app/modules/shared/data/model/models.dart';
import 'package:flufflix/app/modules/shared/data/repository/repositories.dart';
import 'package:flufflix/app/modules/shared/domain/contract/contracts.dart';
import 'package:flufflix/app/modules/shared/presentation/bloc/blocs.dart';
import 'package:flufflix/app/modules/shared/presentation/enum/enums.dart';
import 'package:flufflix/app/modules/shared/presentation/event/pop_menu_options_event.dart';
import 'package:flufflix/app/modules/shared/presentation/state/states.dart';

import '../../../../../mock/mocks.dart';

const String id = '123';
const String title = 'title';
const String posterImage = 'poster-image';
const String releaseYear = '2019';

void main() {
  late final PersistentContentRepositoryImpl persistentContentRepositoryImpl;

  setUpAll(() {
    persistentContentRepositoryImpl = MockPersistentContentRepositoryImpl();

    registerFallbackValue(PersistentContentModelFake());
  });

  group('PopMenuOptionsBlocTest', () {
    blocTest<PopMenuOptionsBloc, PopMenuOptionsState>(
      'emite [PopMenuOptionsSuccessState] ao realizar a verificação dos status das opções',
      build: () => PopMenuOptionsBloc(
          persistentContentRepositoryImpl: persistentContentRepositoryImpl),
      act: (bloc) {
        when(() => persistentContentRepositoryImpl.containBadge(
                id, PopMenuOptionsTypeEnum.download))
            .thenReturn(AppResponse(success: false));
        when(() => persistentContentRepositoryImpl.containBadge(
                id, PopMenuOptionsTypeEnum.favorite))
            .thenReturn(
                AppResponse(error: AppError(stackTrace: StackTrace.current)));

        bloc.add(VerifyOptionsStateEvent(id: id, options: [
          PopMenuOptionsTypeEnum.download,
          PopMenuOptionsTypeEnum.favorite
        ]));
      },
      expect: () {
        verify(() => persistentContentRepositoryImpl.containBadge(
            id, PopMenuOptionsTypeEnum.download)).called(1);
        verify(() => persistentContentRepositoryImpl.containBadge(
            id, PopMenuOptionsTypeEnum.favorite)).called(1);

        return [
          PopMenuOptionsLoadingState(),
          PopMenuOptionsSuccessState(options: const [
            PopMenuVerifiedOptionContract(
                isActive: false, type: PopMenuOptionsTypeEnum.download),
            PopMenuVerifiedOptionContract(
                isActive: false, type: PopMenuOptionsTypeEnum.favorite)
          ])
        ];
      },
    );

    blocTest<PopMenuOptionsBloc, PopMenuOptionsState>(
      'emite [PopMenuOptionsSuccessState] ao realizar a atualização das badges corretamente e atualizar o registro',
      build: () => PopMenuOptionsBloc(
          persistentContentRepositoryImpl: persistentContentRepositoryImpl),
      act: (bloc) {
        when(() => persistentContentRepositoryImpl.updateBadgesOrCreate(
                const PersistentContentModel(
                    id: id,
                    title: title,
                    posterImage: posterImage,
                    releaseYear: releaseYear,
                    badges: [],
                    type: ContentTypeEnum.movie),
                PopMenuOptionsTypeEnum.download))
            .thenAnswer((_) async => AppResponse(success: true));
        when(() => persistentContentRepositoryImpl.containBadge(
                id, PopMenuOptionsTypeEnum.download))
            .thenReturn(AppResponse(success: true));

        bloc.add(ExecuteOptionActionEvent(
            id: id,
            title: title,
            posterImage: posterImage,
            activate: true,
            releaseYear: releaseYear,
            type: ContentTypeEnum.movie,
            typeToExecuteAction: PopMenuOptionsTypeEnum.download,
            options: [PopMenuOptionsTypeEnum.download]));
      },
      expect: () {
        verify(() => persistentContentRepositoryImpl.updateBadgesOrCreate(
            const PersistentContentModel(
                id: id,
                title: title,
                posterImage: posterImage,
                releaseYear: releaseYear,
                badges: [],
                type: ContentTypeEnum.movie),
            PopMenuOptionsTypeEnum.download)).called(1);
        verify(() => persistentContentRepositoryImpl.containBadge(
            id, PopMenuOptionsTypeEnum.download)).called(1);

        return [
          PopMenuOptionsLoadingState(),
          PopMenuOptionsSuccessState(options: const [
            PopMenuVerifiedOptionContract(
                isActive: true, type: PopMenuOptionsTypeEnum.download),
          ])
        ];
      },
    );

    blocTest<PopMenuOptionsBloc, PopMenuOptionsState>(
      'emite [PopMenuOptionsErrorState] ao não conseguir realizar a atualização das badges corretamente',
      build: () => PopMenuOptionsBloc(
          persistentContentRepositoryImpl: persistentContentRepositoryImpl),
      act: (bloc) {
        when(() => persistentContentRepositoryImpl.updateBadgesOrCreate(
                const PersistentContentModel(
                    id: id,
                    title: title,
                    posterImage: posterImage,
                    releaseYear: releaseYear,
                    badges: [],
                    type: ContentTypeEnum.movie),
                PopMenuOptionsTypeEnum.download))
            .thenAnswer((_) async => AppResponse(success: false));

        bloc.add(ExecuteOptionActionEvent(
            id: id,
            title: title,
            posterImage: posterImage,
            releaseYear: releaseYear,
            type: ContentTypeEnum.movie,
            activate: true,
            typeToExecuteAction: PopMenuOptionsTypeEnum.download,
            options: [PopMenuOptionsTypeEnum.download]));
      },
      expect: () {
        verify(() => persistentContentRepositoryImpl.updateBadgesOrCreate(
            const PersistentContentModel(
                id: id,
                title: title,
                posterImage: posterImage,
                releaseYear: releaseYear,
                badges: [],
                type: ContentTypeEnum.movie),
            PopMenuOptionsTypeEnum.download)).called(1);
        verifyNever(() => persistentContentRepositoryImpl.containBadge(
            id, PopMenuOptionsTypeEnum.download));

        return [
          PopMenuOptionsLoadingState(),
          PopMenuOptionsErrorState(message: 'Unexpected Error')
        ];
      },
    );

    blocTest<PopMenuOptionsBloc, PopMenuOptionsState>(
      'emite [PopMenuOptionsErrorState] ao retornar AppErro na atualização do registro',
      build: () => PopMenuOptionsBloc(
          persistentContentRepositoryImpl: persistentContentRepositoryImpl),
      act: (bloc) {
        when(() => persistentContentRepositoryImpl.updateBadgesOrCreate(
                const PersistentContentModel(
                    id: id,
                    title: title,
                    posterImage: posterImage,
                    releaseYear: releaseYear,
                    badges: [],
                    type: ContentTypeEnum.movie),
                PopMenuOptionsTypeEnum.download))
            .thenAnswer((_) async => AppResponse(
                error: AppError(
                    stackTrace: StackTrace.current,
                    message: 'Error With Message')));

        bloc.add(ExecuteOptionActionEvent(
            id: id,
            title: title,
            posterImage: posterImage,
            releaseYear: releaseYear,
            type: ContentTypeEnum.movie,
            activate: true,
            typeToExecuteAction: PopMenuOptionsTypeEnum.download,
            options: [PopMenuOptionsTypeEnum.download]));
      },
      expect: () {
        verify(() => persistentContentRepositoryImpl.updateBadgesOrCreate(
            const PersistentContentModel(
                id: id,
                title: title,
                posterImage: posterImage,
                releaseYear: releaseYear,
                badges: [],
                type: ContentTypeEnum.movie),
            PopMenuOptionsTypeEnum.download)).called(1);
        verifyNever(() => persistentContentRepositoryImpl.containBadge(
            id, PopMenuOptionsTypeEnum.download));

        return [
          PopMenuOptionsLoadingState(),
          PopMenuOptionsErrorState(message: 'Error With Message')
        ];
      },
    );

    blocTest<PopMenuOptionsBloc, PopMenuOptionsState>(
      'emite [PopMenuOptionsSuccessState] ao realizar a remoção da badge selecionada corretamente e atualizar o registro',
      build: () => PopMenuOptionsBloc(
          persistentContentRepositoryImpl: persistentContentRepositoryImpl),
      act: (bloc) {
        when(() => persistentContentRepositoryImpl.removeBadgeOrDelete(
                id, PopMenuOptionsTypeEnum.download))
            .thenAnswer((_) async => AppResponse(success: true));
        when(() => persistentContentRepositoryImpl.containBadge(
                id, PopMenuOptionsTypeEnum.download))
            .thenReturn(AppResponse(success: false));

        bloc.add(ExecuteOptionActionEvent(
            id: id,
            title: title,
            posterImage: posterImage,
            releaseYear: releaseYear,
            type: ContentTypeEnum.movie,
            activate: false,
            typeToExecuteAction: PopMenuOptionsTypeEnum.download,
            options: [PopMenuOptionsTypeEnum.download]));
      },
      expect: () {
        verify(() => persistentContentRepositoryImpl.removeBadgeOrDelete(
            id, PopMenuOptionsTypeEnum.download)).called(1);
        verify(() => persistentContentRepositoryImpl.containBadge(
            id, PopMenuOptionsTypeEnum.download)).called(1);

        return [
          PopMenuOptionsLoadingState(),
          PopMenuOptionsSuccessState(options: const [
            PopMenuVerifiedOptionContract(
                isActive: false, type: PopMenuOptionsTypeEnum.download),
          ])
        ];
      },
    );

    blocTest<PopMenuOptionsBloc, PopMenuOptionsState>(
      'emite [PopMenuOptionsErrorState] ao não conseguir realizar a remoção das badges corretamente',
      build: () => PopMenuOptionsBloc(
          persistentContentRepositoryImpl: persistentContentRepositoryImpl),
      act: (bloc) {
        when(() => persistentContentRepositoryImpl.removeBadgeOrDelete(
                id, PopMenuOptionsTypeEnum.download))
            .thenAnswer((_) async => AppResponse(success: false));

        bloc.add(ExecuteOptionActionEvent(
            id: id,
            title: title,
            posterImage: posterImage,
            releaseYear: releaseYear,
            type: ContentTypeEnum.movie,
            activate: false,
            typeToExecuteAction: PopMenuOptionsTypeEnum.download,
            options: [PopMenuOptionsTypeEnum.download]));
      },
      expect: () {
        verify(() => persistentContentRepositoryImpl.removeBadgeOrDelete(
            id, PopMenuOptionsTypeEnum.download)).called(1);
        verifyNever(() => persistentContentRepositoryImpl.containBadge(
            id, PopMenuOptionsTypeEnum.download));

        return [
          PopMenuOptionsLoadingState(),
          PopMenuOptionsErrorState(message: 'Unexpected Error')
        ];
      },
    );

    blocTest<PopMenuOptionsBloc, PopMenuOptionsState>(
      'emite [PopMenuOptionsErrorState] ao retornar AppErro na remoção do registro',
      build: () => PopMenuOptionsBloc(
          persistentContentRepositoryImpl: persistentContentRepositoryImpl),
      act: (bloc) {
        when(() => persistentContentRepositoryImpl.removeBadgeOrDelete(
                id, PopMenuOptionsTypeEnum.download))
            .thenAnswer((_) async => AppResponse(
                error: AppError(
                    stackTrace: StackTrace.current,
                    message: 'Error With Message')));

        bloc.add(ExecuteOptionActionEvent(
            id: id,
            title: title,
            posterImage: posterImage,
            releaseYear: releaseYear,
            type: ContentTypeEnum.movie,
            activate: false,
            typeToExecuteAction: PopMenuOptionsTypeEnum.download,
            options: [PopMenuOptionsTypeEnum.download]));
      },
      expect: () {
        verify(() => persistentContentRepositoryImpl.removeBadgeOrDelete(
            id, PopMenuOptionsTypeEnum.download)).called(1);
        verifyNever(() => persistentContentRepositoryImpl.containBadge(
            id, PopMenuOptionsTypeEnum.download));

        return [
          PopMenuOptionsLoadingState(),
          PopMenuOptionsErrorState(message: 'Error With Message')
        ];
      },
    );
  });
}
