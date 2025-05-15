import 'package:flufflix/app/core/error/errors.dart';
import 'package:flufflix/app/core/response/responses.dart';
import 'package:flufflix/app/modules/content/domain/contract/contracts.dart';
import 'package:flufflix/app/modules/content/presentation/state/states.dart';
import 'package:flufflix/app/modules/content/presentation/store/stores.dart';
import 'package:flufflix/app/modules/shared/data/repository/repositories.dart';
import 'package:flufflix/app/modules/shared/presentation/enum/enums.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mock/factory/factories.dart';
import '../../../../../mock/mocks.dart';
import '../../../../../util/utils.dart';

const String id = '123';

void main() {
  late final PersistentContentRepositoryImpl persistentContentRepositoryImpl;
  late final StoredContentStore storedContentStore;
  late final ValueNotifierTest valueNotifierTest;

  setUpAll(() {
    persistentContentRepositoryImpl = MockPersistentContentRepositoryImpl();
    storedContentStore = StoredContentStore(
        persistentContentRepositoryImpl: persistentContentRepositoryImpl);

    valueNotifierTest = ValueNotifierTest<StoredContentState>(
        notifier: storedContentStore.state);
    valueNotifierTest.enableListener();
  });

  setUp(() {
    valueNotifierTest.resetEmittedValues();
  });

  tearDownAll(() {
    valueNotifierTest.disposeListener();
    storedContentStore.dispose();
  });

  group('StoredContentStoreTest', () {
    group('updateContentList', () {
      test('deve retornar a lista de contratos com sucesso', () {
        final model = PersistentContentFactory.getPersistentContentModel(
            id, [PopMenuOptionsTypeEnum.download]);

        when(
          () => persistentContentRepositoryImpl.getList(),
        ).thenReturn(AppResponse(success: [model]));

        storedContentStore.updateContentList();

        verify(
          () => persistentContentRepositoryImpl.getList(),
        ).called(1);

        expect(valueNotifierTest.emitedValues.length, 2);
        expect(valueNotifierTest.emitedValues, [
          StoredContentLoadingState(),
          StoredContentSuccessState(list: [
            StoredContentCardContract(
                id: model.id,
                title: model.title,
                imagePath: model.posterImage,
                releaseYear: model.releaseYear,
                type: model.type,
                badges: model.badges)
          ])
        ]);
      });

      test('deve retornar um erro com a mensagem genérica', () {
        when(
          () => persistentContentRepositoryImpl.getList(),
        ).thenReturn(
            AppResponse(error: AppError(stackTrace: StackTrace.current)));

        storedContentStore.updateContentList();

        verify(
          () => persistentContentRepositoryImpl.getList(),
        ).called(1);

        expect(valueNotifierTest.emitedValues.length, 2);
        expect(valueNotifierTest.emitedValues, [
          StoredContentLoadingState(),
          StoredContentErrorState(message: "Unexpected Error")
        ]);
      });

      test('deve retornar um erro com a mensagem', () {
        when(
          () => persistentContentRepositoryImpl.getList(),
        ).thenReturn(AppResponse(
            error: AppError(
                stackTrace: StackTrace.current,
                message: 'Error With Message')));

        storedContentStore.updateContentList();

        verify(
          () => persistentContentRepositoryImpl.getList(),
        ).called(1);

        expect(valueNotifierTest.emitedValues.length, 2);
        expect(valueNotifierTest.emitedValues, [
          StoredContentLoadingState(),
          StoredContentErrorState(message: 'Error With Message')
        ]);
      });
    });
  });
}
