import 'package:flufflix/components/content/contract/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flufflix/core/states/index.dart';
import 'package:flufflix/core/events/index.dart';

class ContentListBloc<T extends ContentListItemContract>
    extends Bloc<ContentListEvent, ContentListState> {
  ContentListBloc() : super(ContentListInitialState()) {
    on<FecthContentListData<T>>(_fecthContentListData);
  }

  Future<void> _fecthContentListData(
      FecthContentListData<T> event, Emitter emit) async {
    emit(ContentListLoadingState());

    try {
      final newContentList = await event.fecthFunctionData();

      emit(ContentListSuccessState<T>(contentList: newContentList));
    } catch (_) {
      emit(ContentListErrorState());
    }
  }
}
