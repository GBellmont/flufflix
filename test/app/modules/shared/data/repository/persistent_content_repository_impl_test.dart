import 'package:flufflix/app/modules/shared/data/model/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flufflix/app/core/error/errors.dart';
import 'package:flufflix/app/core/response/app_response.dart';

import 'package:flufflix/app/modules/shared/data/external/externals.dart';
import 'package:flufflix/app/modules/shared/data/repository/repositories.dart';
import 'package:flufflix/app/modules/shared/presentation/enum/enums.dart';

import '../../../../../mock/factory/factories.dart';
import '../../../../../mock/mocks.dart';

const String id = '123';

void main() {
  late final PersistentContentDataSource persistentContentDataSource;
  late final PersistentContentRepositoryImpl persistentContentRepositoryImpl;

  setUpAll(() {
    persistentContentDataSource = MockPersistentContentDataSource();
    persistentContentRepositoryImpl = PersistentContentRepositoryImpl(
        persistentDataSource: persistentContentDataSource);

    registerFallbackValue(PersistentContentModelFake());
  });

  group('PersistentContentRepositoryImplTest', () {
    group('containBadge', () {
      test('deve retornar false caso não ache nenhum registro', () {
        when(() => persistentContentDataSource.findById(id)).thenReturn(null);

        final response = persistentContentRepositoryImpl.containBadge(
            id, PopMenuOptionsTypeEnum.download);

        verify(() => persistentContentDataSource.findById(id)).called(1);

        expect(response, isA<AppResponse<bool>>());
        expect(response.hasError, isFalse);
        expect(response.success, isFalse);
      });

      test('deve retornar false caso o registro não possua a badge selecionada',
          () {
        final model = PersistentContentFactory.getPersistentContentModel(
            id, [PopMenuOptionsTypeEnum.favorite]);

        when(() => persistentContentDataSource.findById(id)).thenReturn(model);

        final response = persistentContentRepositoryImpl.containBadge(
            id, PopMenuOptionsTypeEnum.download);

        verify(() => persistentContentDataSource.findById(id)).called(1);

        expect(response, isA<AppResponse<bool>>());
        expect(response.hasError, isFalse);
        expect(response.success, isFalse);
      });

      test('deve retornar true caso o registro possua a badge selecionada', () {
        final model = PersistentContentFactory.getPersistentContentModel(
            id, [PopMenuOptionsTypeEnum.download]);

        when(() => persistentContentDataSource.findById(id)).thenReturn(model);

        final response = persistentContentRepositoryImpl.containBadge(
            id, PopMenuOptionsTypeEnum.download);

        verify(() => persistentContentDataSource.findById(id)).called(1);

        expect(response, isA<AppResponse<bool>>());
        expect(response.hasError, isFalse);
        expect(response.success, isTrue);
      });

      test('deve retornar erro caso ocorra um AppError', () {
        when(() => persistentContentDataSource.findById(id))
            .thenThrow(AppError(stackTrace: StackTrace.current));

        final response = persistentContentRepositoryImpl.containBadge(
            id, PopMenuOptionsTypeEnum.download);

        verify(() => persistentContentDataSource.findById(id)).called(1);

        expect(response, isA<AppResponse<bool>>());
        expect(response.hasError, isTrue);
        expect(response.error, isA<AppError>());
      });

      test('deve lançar uma exceção caso a mesma seja genérica', () {
        when(() => persistentContentDataSource.findById(id))
            .thenThrow(Exception());

        expect(
            () => persistentContentRepositoryImpl.containBadge(
                id, PopMenuOptionsTypeEnum.download),
            throwsA(isA<Exception>()));

        verify(() => persistentContentDataSource.findById(id)).called(1);
      });
    });

    group('removeBadgeOrDelete', () {
      test('deve retornar true caso não ache nenhum registro', () async {
        when(() => persistentContentDataSource.findById(id)).thenReturn(null);

        final response = await persistentContentRepositoryImpl
            .removeBadgeOrDelete(id, PopMenuOptionsTypeEnum.download);

        verify(() => persistentContentDataSource.findById(id)).called(1);
        verifyNever(() => persistentContentDataSource.delete(any()));
        verifyNever(() => persistentContentDataSource.update(any()));

        expect(response, isA<AppResponse<bool>>());
        expect(response.hasError, isFalse);
        expect(response.success, isTrue);
      });

      test(
          'deve retornar true caso ache um registro sem badges e apague o mesmo',
          () async {
        final registeredModel =
            PersistentContentFactory.getPersistentContentModel(id, []);

        when(() => persistentContentDataSource.findById(id))
            .thenReturn(registeredModel);
        when(() => persistentContentDataSource.delete(id))
            .thenAnswer((_) async => true);

        final response = await persistentContentRepositoryImpl
            .removeBadgeOrDelete(id, PopMenuOptionsTypeEnum.download);

        verify(() => persistentContentDataSource.findById(id)).called(1);
        verify(() => persistentContentDataSource.delete(id)).called(1);
        verifyNever(() => persistentContentDataSource.update(any()));

        expect(response, isA<AppResponse<bool>>());
        expect(response.hasError, isFalse);
        expect(response.success, isTrue);
      });

      test(
          'deve retornar true caso ache um registro com uma unica badge identica a selecionada e apague o mesmo',
          () async {
        final registeredModel =
            PersistentContentFactory.getPersistentContentModel(
                id, [PopMenuOptionsTypeEnum.download]);

        when(() => persistentContentDataSource.findById(id))
            .thenReturn(registeredModel);
        when(() => persistentContentDataSource.delete(id))
            .thenAnswer((_) async => true);

        final response = await persistentContentRepositoryImpl
            .removeBadgeOrDelete(id, PopMenuOptionsTypeEnum.download);

        verify(() => persistentContentDataSource.findById(id)).called(1);
        verify(() => persistentContentDataSource.delete(id)).called(1);
        verifyNever(() => persistentContentDataSource.update(any()));

        expect(response, isA<AppResponse<bool>>());
        expect(response.hasError, isFalse);
        expect(response.success, isTrue);
      });

      test(
          'deve retornar true quando remover a badge selecionada e atualizar o registro',
          () async {
        final registeredModel =
            PersistentContentFactory.getPersistentContentModel(id, [
          PopMenuOptionsTypeEnum.download,
          PopMenuOptionsTypeEnum.favorite
        ]);

        when(() => persistentContentDataSource.findById(id))
            .thenReturn(registeredModel);
        when(() => persistentContentDataSource.update(registeredModel
                .copyWith(badges: [PopMenuOptionsTypeEnum.favorite])))
            .thenAnswer((_) async => true);

        final response = await persistentContentRepositoryImpl
            .removeBadgeOrDelete(id, PopMenuOptionsTypeEnum.download);

        verify(() => persistentContentDataSource.findById(id)).called(1);
        verifyNever(() => persistentContentDataSource.delete(id));
        verify(() => persistentContentDataSource.update(registeredModel
            .copyWith(badges: [PopMenuOptionsTypeEnum.favorite]))).called(1);

        expect(response, isA<AppResponse<bool>>());
        expect(response.hasError, isFalse);
        expect(response.success, isTrue);
      });

      test('deve retornar false quando não conseguir atualizar o registro',
          () async {
        final registeredModel =
            PersistentContentFactory.getPersistentContentModel(id, [
          PopMenuOptionsTypeEnum.download,
          PopMenuOptionsTypeEnum.favorite
        ]);

        when(() => persistentContentDataSource.findById(id))
            .thenReturn(registeredModel);
        when(() => persistentContentDataSource.update(registeredModel
                .copyWith(badges: [PopMenuOptionsTypeEnum.favorite])))
            .thenAnswer((_) async => false);

        final response = await persistentContentRepositoryImpl
            .removeBadgeOrDelete(id, PopMenuOptionsTypeEnum.download);

        verify(() => persistentContentDataSource.findById(id)).called(1);
        verifyNever(() => persistentContentDataSource.delete(id));
        verify(() => persistentContentDataSource.update(registeredModel
            .copyWith(badges: [PopMenuOptionsTypeEnum.favorite]))).called(1);

        expect(response, isA<AppResponse<bool>>());
        expect(response.hasError, isFalse);
        expect(response.success, isFalse);
      });

      test('deve retornar false caso não consiga apagar um registro', () async {
        final registeredModel =
            PersistentContentFactory.getPersistentContentModel(
                id, [PopMenuOptionsTypeEnum.download]);

        when(() => persistentContentDataSource.findById(id))
            .thenReturn(registeredModel);
        when(() => persistentContentDataSource.delete(id))
            .thenAnswer((_) async => false);

        final response = await persistentContentRepositoryImpl
            .removeBadgeOrDelete(id, PopMenuOptionsTypeEnum.download);

        verify(() => persistentContentDataSource.findById(id)).called(1);
        verify(() => persistentContentDataSource.delete(id)).called(1);
        verifyNever(() => persistentContentDataSource.update(any()));

        expect(response, isA<AppResponse<bool>>());
        expect(response.hasError, isFalse);
        expect(response.success, isFalse);
      });

      test('deve retornar erro caso ocorra um AppError', () async {
        final registeredModel =
            PersistentContentFactory.getPersistentContentModel(id, [
          PopMenuOptionsTypeEnum.download,
          PopMenuOptionsTypeEnum.favorite
        ]);

        when(() => persistentContentDataSource.findById(id))
            .thenReturn(registeredModel);
        when(() => persistentContentDataSource.update(registeredModel
                .copyWith(badges: [PopMenuOptionsTypeEnum.favorite])))
            .thenThrow(AppError(stackTrace: StackTrace.current));

        final response = await persistentContentRepositoryImpl
            .removeBadgeOrDelete(id, PopMenuOptionsTypeEnum.download);

        verify(() => persistentContentDataSource.findById(id)).called(1);
        verifyNever(() => persistentContentDataSource.delete(id));
        verify(() => persistentContentDataSource.update(registeredModel
            .copyWith(badges: [PopMenuOptionsTypeEnum.favorite]))).called(1);

        expect(response, isA<AppResponse<bool>>());
        expect(response.hasError, isTrue);
        expect(response.error, isA<AppError>());
      });

      test('deve lançar uma exceção caso a mesma seja genérica', () async {
        final registeredModel =
            PersistentContentFactory.getPersistentContentModel(id, [
          PopMenuOptionsTypeEnum.download,
          PopMenuOptionsTypeEnum.favorite
        ]);

        when(() => persistentContentDataSource.findById(id))
            .thenReturn(registeredModel);
        when(() => persistentContentDataSource.update(registeredModel.copyWith(
            badges: [PopMenuOptionsTypeEnum.favorite]))).thenThrow(Exception());

        expect(
            () async => await persistentContentRepositoryImpl
                .removeBadgeOrDelete(id, PopMenuOptionsTypeEnum.download),
            throwsA(isA<Exception>()));

        verify(() => persistentContentDataSource.findById(id)).called(1);
        verifyNever(() => persistentContentDataSource.delete(id));
        verify(() => persistentContentDataSource.update(registeredModel
            .copyWith(badges: [PopMenuOptionsTypeEnum.favorite]))).called(1);
      });
    });

    group('updateBadgesOrCreate', () {
      test('deve criar um novo conteúdo caso não ache nenhum registro',
          () async {
        final model =
            PersistentContentFactory.getPersistentContentModel(id, []);

        when(() => persistentContentDataSource.findById(id)).thenReturn(null);
        when(() => persistentContentDataSource
                .add(model.copyWith(badges: [PopMenuOptionsTypeEnum.download])))
            .thenAnswer((_) async => true);

        final response = await persistentContentRepositoryImpl
            .updateBadgesOrCreate(model, PopMenuOptionsTypeEnum.download);

        verify(() => persistentContentDataSource.findById(id)).called(1);
        verify(() => persistentContentDataSource
                .add(model.copyWith(badges: [PopMenuOptionsTypeEnum.download])))
            .called(1);
        verifyNever(() => persistentContentDataSource.update(any()));

        expect(response, isA<AppResponse<bool>>());
        expect(response.hasError, isFalse);
        expect(response.success, isTrue);
      });

      test('deve retornar false quando não conseguir criar registro', () async {
        final model =
            PersistentContentFactory.getPersistentContentModel(id, []);

        when(() => persistentContentDataSource.findById(id)).thenReturn(null);
        when(() => persistentContentDataSource
                .add(model.copyWith(badges: [PopMenuOptionsTypeEnum.download])))
            .thenAnswer((_) async => false);

        final response = await persistentContentRepositoryImpl
            .updateBadgesOrCreate(model, PopMenuOptionsTypeEnum.download);

        verify(() => persistentContentDataSource.findById(id)).called(1);
        verify(() => persistentContentDataSource
                .add(model.copyWith(badges: [PopMenuOptionsTypeEnum.download])))
            .called(1);
        verifyNever(() => persistentContentDataSource.update(any()));

        expect(response, isA<AppResponse<bool>>());
        expect(response.hasError, isFalse);
        expect(response.success, isFalse);
      });

      test(
          'deve registrar as mesmas badges caso o conteúdo já tenha à selecionada',
          () async {
        final registeredModel =
            PersistentContentFactory.getPersistentContentModel(
                id, [PopMenuOptionsTypeEnum.download]);
        final model =
            PersistentContentFactory.getPersistentContentModel(id, []);

        when(() => persistentContentDataSource.findById(id))
            .thenReturn(registeredModel);
        when(() => persistentContentDataSource.update(registeredModel))
            .thenAnswer((_) async => true);

        final response = await persistentContentRepositoryImpl
            .updateBadgesOrCreate(model, PopMenuOptionsTypeEnum.download);

        verify(() => persistentContentDataSource.findById(id)).called(1);
        verifyNever(() => persistentContentDataSource.add(any()));
        verify(() => persistentContentDataSource.update(registeredModel))
            .called(1);

        expect(response, isA<AppResponse<bool>>());
        expect(response.hasError, isFalse);
        expect(response.success, isTrue);
      });

      test(
          'deve registrar a nova badge caso o conteúdo não tenha à selecionada',
          () async {
        final registeredModel =
            PersistentContentFactory.getPersistentContentModel(
                id, [PopMenuOptionsTypeEnum.favorite]);
        final model =
            PersistentContentFactory.getPersistentContentModel(id, []);

        when(() => persistentContentDataSource.findById(id))
            .thenReturn(registeredModel);
        when(() => persistentContentDataSource.update(registeredModel.copyWith(
                badges: [
                  PopMenuOptionsTypeEnum.favorite,
                  PopMenuOptionsTypeEnum.download
                ]))).thenAnswer((_) async => true);

        final response = await persistentContentRepositoryImpl
            .updateBadgesOrCreate(model, PopMenuOptionsTypeEnum.download);

        verify(() => persistentContentDataSource.findById(id)).called(1);
        verifyNever(() => persistentContentDataSource.add(any()));
        verify(() => persistentContentDataSource.update(registeredModel
                .copyWith(badges: [
              PopMenuOptionsTypeEnum.favorite,
              PopMenuOptionsTypeEnum.download
            ]))).called(1);

        expect(response, isA<AppResponse<bool>>());
        expect(response.hasError, isFalse);
        expect(response.success, isTrue);
      });

      test('deve retornar false quando não conseguir atualizar o registro',
          () async {
        final registeredModel =
            PersistentContentFactory.getPersistentContentModel(
                id, [PopMenuOptionsTypeEnum.download]);
        final model =
            PersistentContentFactory.getPersistentContentModel(id, []);

        when(() => persistentContentDataSource.findById(id))
            .thenReturn(registeredModel);
        when(() => persistentContentDataSource.update(registeredModel))
            .thenAnswer((_) async => false);

        final response = await persistentContentRepositoryImpl
            .updateBadgesOrCreate(model, PopMenuOptionsTypeEnum.download);

        verify(() => persistentContentDataSource.findById(id)).called(1);
        verifyNever(() => persistentContentDataSource.add(any()));
        verify(() => persistentContentDataSource.update(registeredModel))
            .called(1);

        expect(response, isA<AppResponse<bool>>());
        expect(response.hasError, isFalse);
        expect(response.success, isFalse);
      });

      test('deve retornar erro caso ocorra um AppError', () async {
        final registeredModel =
            PersistentContentFactory.getPersistentContentModel(
                id, [PopMenuOptionsTypeEnum.download]);
        final model =
            PersistentContentFactory.getPersistentContentModel(id, []);

        when(() => persistentContentDataSource.findById(id))
            .thenReturn(registeredModel);
        when(() => persistentContentDataSource.update(registeredModel))
            .thenThrow(AppError(stackTrace: StackTrace.current));

        final response = await persistentContentRepositoryImpl
            .updateBadgesOrCreate(model, PopMenuOptionsTypeEnum.download);

        verify(() => persistentContentDataSource.findById(id)).called(1);
        verifyNever(() => persistentContentDataSource.add(any()));
        verify(() => persistentContentDataSource.update(registeredModel))
            .called(1);

        expect(response, isA<AppResponse<bool>>());
        expect(response.hasError, isTrue);
        expect(response.error, isA<AppError>());
      });

      test('deve lançar uma exceção caso a mesma seja genérica', () async {
        final registeredModel =
            PersistentContentFactory.getPersistentContentModel(
                id, [PopMenuOptionsTypeEnum.download]);
        final model =
            PersistentContentFactory.getPersistentContentModel(id, []);

        when(() => persistentContentDataSource.findById(id))
            .thenReturn(registeredModel);
        when(() => persistentContentDataSource.update(registeredModel))
            .thenThrow(Exception());

        expect(
            () async => await persistentContentRepositoryImpl
                .updateBadgesOrCreate(model, PopMenuOptionsTypeEnum.download),
            throwsA(isA<Exception>()));

        verify(() => persistentContentDataSource.findById(id)).called(1);
        verifyNever(() => persistentContentDataSource.add(any()));
        verify(() => persistentContentDataSource.update(registeredModel))
            .called(1);
      });
    });

    group('getList', () {
      test('deve retornar uma liista vazia caso não ache nenhum registro', () {
        when(() => persistentContentDataSource.getList()).thenReturn([]);

        final response = persistentContentRepositoryImpl.getList();

        verify(() => persistentContentDataSource.getList()).called(1);

        expect(response, isA<AppResponse<List<PersistentContentModel>>>());
        expect(response.hasError, isFalse);
        expect(response.success, []);
      });

      test('deve retornar erro caso ocorra um AppError', () {
        when(() => persistentContentDataSource.getList())
            .thenThrow(AppError(stackTrace: StackTrace.current));

        final response = persistentContentRepositoryImpl.getList();

        verify(() => persistentContentDataSource.getList()).called(1);

        expect(response, isA<AppResponse<List<PersistentContentModel>>>());
        expect(response.hasError, isTrue);
        expect(response.error, isA<AppError>());
      });

      test('deve lançar uma exceção caso a mesma seja genérica', () {
        when(() => persistentContentDataSource.getList())
            .thenThrow(Exception());

        expect(() => persistentContentRepositoryImpl.getList(),
            throwsA(isA<Exception>()));

        verify(() => persistentContentDataSource.getList()).called(1);
      });
    });
  });
}
