import 'package:flufflix/app/modules/content/presentation/state/states.dart';
import 'package:flufflix/app/modules/shared/data/repository/repositories.dart';
import 'package:flutter/material.dart';

class StoredContentStore {
  final PersistentContentRepositoryImpl persistentContentRepositoryImpl;

  ValueNotifier<StoredContentState> state =
      ValueNotifier(StoredContentInitialState());

  StoredContentStore({required this.persistentContentRepositoryImpl});

  Future<void> updateContentList() async {
    state.value = StoredContentLoadingState();

    final response = persistentContentRepositoryImpl.getList();

    state.value = response.hasError
        ? StoredContentErrorState(
            message: response.error?.message ?? "Unexpected Error")
        : StoredContentSuccessState(
            list: response.success!
                .map((item) => item.toStoredContentCardContract())
                .toList());
  }

  void dispose() {
    state.dispose();
  }
}
