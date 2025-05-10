import 'dart:convert';

import 'package:flufflix/app/core/error/errors.dart';
import 'package:flufflix/app/modules/shared/data/external/externals.dart';
import 'package:flufflix/app/modules/shared/data/model/models.dart';
import 'package:flufflix/app/modules/shared/presentation/enum/enums.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../mock/factory/factories.dart';
import '../../../../../mock/mocks.dart';

const String id = '123';

void main() {
  late final SharedPreferences persistentManager;
  late final PersistentContentDataSource persistentContentDataSource;

  setUpAll(() {
    persistentManager = MockSharedPreferences();
    persistentContentDataSource =
        PersistentContentDataSource(persistentManager: persistentManager);
  });

  group('PersistentContentDataSourceTest', () {
    group('findById', () {
      test('deve retornar null quando não houver nenhum dado no repositório',
          () {
        when(() => persistentManager.getString(
                PersistentContentDataSource.persistentContentListKey))
            .thenReturn(null);

        final response = persistentContentDataSource.findById(id);

        verify(() => persistentManager.getString(
            PersistentContentDataSource.persistentContentListKey)).called(1);

        expect(response, isNull);
      });

      test('deve retornar null quando não houverem registros no repositório',
          () {
        when(() => persistentManager.getString(
                PersistentContentDataSource.persistentContentListKey))
            .thenReturn(PersistentContentFactory.getEmptyContentList());

        final response = persistentContentDataSource.findById(id);

        verify(() => persistentManager.getString(
            PersistentContentDataSource.persistentContentListKey)).called(1);

        expect(response, isNull);
      });

      test('deve retornar registro quando o mesmo estiver no repositório', () {
        when(() => persistentManager.getString(
                PersistentContentDataSource.persistentContentListKey))
            .thenReturn(PersistentContentFactory.getPopuledContentList(
                [PersistentContentFactory.getPersistentContentModel(id, [])]));

        final response = persistentContentDataSource.findById(id);

        verify(() => persistentManager.getString(
            PersistentContentDataSource.persistentContentListKey)).called(1);

        expect(response, isA<PersistentContentModel>());
      });

      test('deve retornar PersistentError quando houver alguma exceção', () {
        when(() => persistentManager.getString(
                PersistentContentDataSource.persistentContentListKey))
            .thenThrow(Exception());

        expect(
            () => persistentContentDataSource.findById(id),
            throwsA(isA<PersistentError>().having(
                (item) => item.message,
                'message',
                'An error occurred while querying the selected content')));

        verify(() => persistentManager.getString(
            PersistentContentDataSource.persistentContentListKey)).called(1);
      });
    });

    group('add', () {
      test(
          'deve salvar uma lista com apenas um elemento quando não houver nenhum dado no repositório',
          () async {
        final newModel =
            PersistentContentFactory.getPersistentContentModel(id, []);
        final expectedList = jsonEncode({
          'contentList': [newModel.toJson()]
        });

        when(() => persistentManager.getString(
                PersistentContentDataSource.persistentContentListKey))
            .thenReturn(null);
        when(() => persistentManager.setString(
            PersistentContentDataSource.persistentContentListKey,
            expectedList)).thenAnswer((_) async => true);

        final response = await persistentContentDataSource.add(newModel);

        verify(() => persistentManager.getString(
            PersistentContentDataSource.persistentContentListKey)).called(1);
        verify(() => persistentManager.setString(
            PersistentContentDataSource.persistentContentListKey,
            expectedList)).called(1);

        expect(response, isTrue);
      });

      test(
          'deve salvar uma lista com apenas um elemento quando não houverem registros no repositório',
          () async {
        final newModel =
            PersistentContentFactory.getPersistentContentModel(id, []);
        final expectedList = jsonEncode({
          'contentList': [newModel.toJson()]
        });

        when(() => persistentManager.getString(
                PersistentContentDataSource.persistentContentListKey))
            .thenReturn(PersistentContentFactory.getEmptyContentList());
        when(() => persistentManager.setString(
            PersistentContentDataSource.persistentContentListKey,
            expectedList)).thenAnswer((_) async => true);

        final response = await persistentContentDataSource.add(newModel);

        verify(() => persistentManager.getString(
            PersistentContentDataSource.persistentContentListKey)).called(1);
        verify(() => persistentManager.setString(
            PersistentContentDataSource.persistentContentListKey,
            expectedList)).called(1);

        expect(response, isTrue);
      });

      test('deve salvar uma nova lista com o novo elemento corretamente',
          () async {
        final registeredModel =
            PersistentContentFactory.getPersistentContentModel('123', []);
        final newModel =
            PersistentContentFactory.getPersistentContentModel(id, []);
        final expectedList = jsonEncode({
          'contentList': [registeredModel.toJson(), newModel.toJson()]
        });

        when(() => persistentManager.getString(
            PersistentContentDataSource
                .persistentContentListKey)).thenReturn(
            PersistentContentFactory.getPopuledContentList([registeredModel]));
        when(() => persistentManager.setString(
            PersistentContentDataSource.persistentContentListKey,
            expectedList)).thenAnswer((_) async => true);

        final response = await persistentContentDataSource.add(newModel);

        verify(() => persistentManager.getString(
            PersistentContentDataSource.persistentContentListKey)).called(1);
        verify(() => persistentManager.setString(
            PersistentContentDataSource.persistentContentListKey,
            expectedList)).called(1);

        expect(response, isTrue);
      });

      test('deve retornar false quando não conseguir salvar elemento',
          () async {
        final registeredModel =
            PersistentContentFactory.getPersistentContentModel('123', []);
        final newModel =
            PersistentContentFactory.getPersistentContentModel(id, []);
        final expectedList = jsonEncode({
          'contentList': [registeredModel.toJson(), newModel.toJson()]
        });

        when(() => persistentManager.getString(
            PersistentContentDataSource
                .persistentContentListKey)).thenReturn(
            PersistentContentFactory.getPopuledContentList([registeredModel]));
        when(() => persistentManager.setString(
            PersistentContentDataSource.persistentContentListKey,
            expectedList)).thenAnswer((_) async => false);

        final response = await persistentContentDataSource.add(newModel);

        verify(() => persistentManager.getString(
            PersistentContentDataSource.persistentContentListKey)).called(1);
        verify(() => persistentManager.setString(
            PersistentContentDataSource.persistentContentListKey,
            expectedList)).called(1);

        expect(response, isFalse);
      });

      test('deve retornar PersistentError caso ocorra alguma exceção',
          () async {
        final registeredModel =
            PersistentContentFactory.getPersistentContentModel('123', []);
        final newModel =
            PersistentContentFactory.getPersistentContentModel(id, []);
        final expectedList = jsonEncode({
          'contentList': [registeredModel.toJson(), newModel.toJson()]
        });

        when(() => persistentManager.getString(
            PersistentContentDataSource
                .persistentContentListKey)).thenReturn(
            PersistentContentFactory.getPopuledContentList([registeredModel]));
        when(() => persistentManager.setString(
            PersistentContentDataSource.persistentContentListKey,
            expectedList)).thenThrow(Exception());

        expect(
            () async => await persistentContentDataSource.add(newModel),
            throwsA(isA<PersistentError>().having(
                (item) => item.message,
                'message',
                'An error occurred while trying to add new content')));

        verify(() => persistentManager.getString(
            PersistentContentDataSource.persistentContentListKey)).called(1);
        verify(() => persistentManager.setString(
            PersistentContentDataSource.persistentContentListKey,
            expectedList)).called(1);
      });
    });

    group('update', () {
      test(
          'deve salvar uma lista vazia quando não houver nenhum dado no repositório',
          () async {
        final newModel =
            PersistentContentFactory.getPersistentContentModel(id, []);

        when(() => persistentManager.getString(
                PersistentContentDataSource.persistentContentListKey))
            .thenReturn(null);
        when(() => persistentManager.setString(
                PersistentContentDataSource.persistentContentListKey,
                PersistentContentFactory.getEmptyContentList()))
            .thenAnswer((_) async => true);

        final response = await persistentContentDataSource.update(newModel);

        verify(() => persistentManager.getString(
            PersistentContentDataSource.persistentContentListKey)).called(1);
        verify(() => persistentManager.setString(
            PersistentContentDataSource.persistentContentListKey,
            PersistentContentFactory.getEmptyContentList())).called(1);

        expect(response, isTrue);
      });

      test(
          'deve salvar uma lista vazia quando não houverem registros no repositório',
          () async {
        final newModel =
            PersistentContentFactory.getPersistentContentModel(id, []);

        when(() => persistentManager.getString(
                PersistentContentDataSource.persistentContentListKey))
            .thenReturn(PersistentContentFactory.getEmptyContentList());
        when(() => persistentManager.setString(
                PersistentContentDataSource.persistentContentListKey,
                PersistentContentFactory.getEmptyContentList()))
            .thenAnswer((_) async => true);

        final response = await persistentContentDataSource.update(newModel);

        verify(() => persistentManager.getString(
            PersistentContentDataSource.persistentContentListKey)).called(1);
        verify(() => persistentManager.setString(
            PersistentContentDataSource.persistentContentListKey,
            PersistentContentFactory.getEmptyContentList())).called(1);

        expect(response, isTrue);
      });

      test('deve realizar o update de um elemento corretamente', () async {
        final registeredModel =
            PersistentContentFactory.getPersistentContentModel(
                id, [PopMenuOptionsTypeEnum.download]);
        final newModel = PersistentContentFactory.getPersistentContentModel(
            id, [PopMenuOptionsTypeEnum.favorite]);
        final expectedList = jsonEncode({
          'contentList': [newModel.toJson()]
        });

        when(() => persistentManager.getString(
            PersistentContentDataSource
                .persistentContentListKey)).thenReturn(
            PersistentContentFactory.getPopuledContentList([registeredModel]));
        when(() => persistentManager.setString(
            PersistentContentDataSource.persistentContentListKey,
            expectedList)).thenAnswer((_) async => true);

        final response = await persistentContentDataSource.update(newModel);

        verify(() => persistentManager.getString(
            PersistentContentDataSource.persistentContentListKey)).called(1);
        verify(() => persistentManager.setString(
            PersistentContentDataSource.persistentContentListKey,
            expectedList)).called(1);

        expect(response, isTrue);
      });

      test('deve retornar false quando não conseguir alterar um elemento',
          () async {
        final registeredModel =
            PersistentContentFactory.getPersistentContentModel(
                id, [PopMenuOptionsTypeEnum.download]);
        final newModel = PersistentContentFactory.getPersistentContentModel(
            id, [PopMenuOptionsTypeEnum.favorite]);
        final expectedList = jsonEncode({
          'contentList': [newModel.toJson()]
        });

        when(() => persistentManager.getString(
            PersistentContentDataSource
                .persistentContentListKey)).thenReturn(
            PersistentContentFactory.getPopuledContentList([registeredModel]));
        when(() => persistentManager.setString(
            PersistentContentDataSource.persistentContentListKey,
            expectedList)).thenAnswer((_) async => false);

        final response = await persistentContentDataSource.update(newModel);

        verify(() => persistentManager.getString(
            PersistentContentDataSource.persistentContentListKey)).called(1);
        verify(() => persistentManager.setString(
            PersistentContentDataSource.persistentContentListKey,
            expectedList)).called(1);

        expect(response, isFalse);
      });

      test('deve retornar PersistentError caso ocorra alguma exceção',
          () async {
        final registeredModel =
            PersistentContentFactory.getPersistentContentModel(
                id, [PopMenuOptionsTypeEnum.download]);
        final newModel = PersistentContentFactory.getPersistentContentModel(
            id, [PopMenuOptionsTypeEnum.favorite]);
        final expectedList = jsonEncode({
          'contentList': [newModel.toJson()]
        });

        when(() => persistentManager.getString(
            PersistentContentDataSource
                .persistentContentListKey)).thenReturn(
            PersistentContentFactory.getPopuledContentList([registeredModel]));
        when(() => persistentManager.setString(
            PersistentContentDataSource.persistentContentListKey,
            expectedList)).thenThrow(Exception());

        expect(
            () async => await persistentContentDataSource.update(newModel),
            throwsA(isA<PersistentError>().having(
                (item) => item.message,
                'message',
                'An error occurred while trying to update content')));

        verify(() => persistentManager.getString(
            PersistentContentDataSource.persistentContentListKey)).called(1);
        verify(() => persistentManager.setString(
            PersistentContentDataSource.persistentContentListKey,
            expectedList)).called(1);
      });
    });

    group('delete', () {
      test(
          'deve salvar uma lista vazia quando não houver nenhum dado no repositório',
          () async {
        when(() => persistentManager.getString(
                PersistentContentDataSource.persistentContentListKey))
            .thenReturn(null);
        when(() => persistentManager.setString(
                PersistentContentDataSource.persistentContentListKey,
                PersistentContentFactory.getEmptyContentList()))
            .thenAnswer((_) async => true);

        final response = await persistentContentDataSource.delete(id);

        verify(() => persistentManager.getString(
            PersistentContentDataSource.persistentContentListKey)).called(1);
        verify(() => persistentManager.setString(
            PersistentContentDataSource.persistentContentListKey,
            PersistentContentFactory.getEmptyContentList())).called(1);

        expect(response, isTrue);
      });

      test(
          'deve salvar uma lista vazia quando não houverem registros no repositório',
          () async {
        when(() => persistentManager.getString(
                PersistentContentDataSource.persistentContentListKey))
            .thenReturn(PersistentContentFactory.getEmptyContentList());
        when(() => persistentManager.setString(
                PersistentContentDataSource.persistentContentListKey,
                PersistentContentFactory.getEmptyContentList()))
            .thenAnswer((_) async => true);

        final response = await persistentContentDataSource.delete(id);

        verify(() => persistentManager.getString(
            PersistentContentDataSource.persistentContentListKey)).called(1);
        verify(() => persistentManager.setString(
            PersistentContentDataSource.persistentContentListKey,
            PersistentContentFactory.getEmptyContentList())).called(1);

        expect(response, isTrue);
      });

      test('deve apagar um elemento corretamente', () async {
        final registeredModel =
            PersistentContentFactory.getPersistentContentModel(
                id, [PopMenuOptionsTypeEnum.download]);

        when(() => persistentManager.getString(
            PersistentContentDataSource
                .persistentContentListKey)).thenReturn(
            PersistentContentFactory.getPopuledContentList([registeredModel]));
        when(() => persistentManager.setString(
                PersistentContentDataSource.persistentContentListKey,
                PersistentContentFactory.getEmptyContentList()))
            .thenAnswer((_) async => true);

        final response = await persistentContentDataSource.delete(id);

        verify(() => persistentManager.getString(
            PersistentContentDataSource.persistentContentListKey)).called(1);
        verify(() => persistentManager.setString(
            PersistentContentDataSource.persistentContentListKey,
            PersistentContentFactory.getEmptyContentList())).called(1);

        expect(response, isTrue);
      });

      test('deve retornar false quando não conseguir apagar um elemento',
          () async {
        final registeredModel =
            PersistentContentFactory.getPersistentContentModel(
                id, [PopMenuOptionsTypeEnum.download]);

        when(() => persistentManager.getString(
            PersistentContentDataSource
                .persistentContentListKey)).thenReturn(
            PersistentContentFactory.getPopuledContentList([registeredModel]));
        when(() => persistentManager.setString(
                PersistentContentDataSource.persistentContentListKey,
                PersistentContentFactory.getEmptyContentList()))
            .thenAnswer((_) async => false);

        final response = await persistentContentDataSource.delete(id);

        verify(() => persistentManager.getString(
            PersistentContentDataSource.persistentContentListKey)).called(1);
        verify(() => persistentManager.setString(
            PersistentContentDataSource.persistentContentListKey,
            PersistentContentFactory.getEmptyContentList())).called(1);

        expect(response, isFalse);
      });

      test('deve retornar PersistentError caso ocorra alguma exceção',
          () async {
        final registeredModel =
            PersistentContentFactory.getPersistentContentModel(
                id, [PopMenuOptionsTypeEnum.download]);

        when(() => persistentManager.getString(
            PersistentContentDataSource
                .persistentContentListKey)).thenReturn(
            PersistentContentFactory.getPopuledContentList([registeredModel]));
        when(() => persistentManager.setString(
                PersistentContentDataSource.persistentContentListKey,
                PersistentContentFactory.getEmptyContentList()))
            .thenThrow(Exception());

        expect(
            () async => await persistentContentDataSource.delete(id),
            throwsA(isA<PersistentError>().having(
                (item) => item.message,
                'message',
                'An error occurred while trying to delete content')));

        verify(() => persistentManager.getString(
            PersistentContentDataSource.persistentContentListKey)).called(1);
        verify(() => persistentManager.setString(
            PersistentContentDataSource.persistentContentListKey,
            PersistentContentFactory.getEmptyContentList())).called(1);
      });
    });
  });
}
