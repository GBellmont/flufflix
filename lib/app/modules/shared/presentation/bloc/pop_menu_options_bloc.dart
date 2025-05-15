import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flufflix/app/modules/shared/data/model/models.dart';
import 'package:flufflix/app/modules/shared/data/repository/repositories.dart';
import 'package:flufflix/app/modules/shared/domain/contract/contracts.dart';
import 'package:flufflix/app/modules/shared/presentation/enum/enums.dart';
import 'package:flufflix/app/modules/shared/presentation/event/events.dart';
import 'package:flufflix/app/modules/shared/presentation/state/states.dart';

class PopMenuOptionsBloc
    extends Bloc<PopMenuOptionsEvent, PopMenuOptionsState> {
  final PersistentContentRepositoryImpl persistentContentRepositoryImpl;

  PopMenuOptionsBloc({required this.persistentContentRepositoryImpl})
      : super(PopMenuOptionsInitialState()) {
    on<VerifyOptionsStateEvent>(_verifyOptionsState);
    on<ExecuteOptionActionEvent>(_executeOptionAction);
  }

  Future<void> _verifyOptionsState(
      VerifyOptionsStateEvent event, Emitter emit) async {
    emit(PopMenuOptionsLoadingState());

    emit(PopMenuOptionsSuccessState(
        options: _verifyOptions(event.id, event.options)));
  }

  Future<void> _executeOptionAction(
      ExecuteOptionActionEvent event, Emitter emit) async {
    emit(PopMenuOptionsLoadingState());

    final response = switch (event.activate) {
      true => await persistentContentRepositoryImpl.updateBadgesOrCreate(
          PersistentContentModel(
              id: event.id,
              title: event.title,
              posterImage: event.posterImage,
              releaseYear: event.releaseYear,
              type: event.type,
              badges: const []),
          event.typeToExecuteAction),
      false => await persistentContentRepositoryImpl.removeBadgeOrDelete(
          event.id, event.typeToExecuteAction)
    };

    response.success ?? false
        ? emit(PopMenuOptionsSuccessState(
            options: _verifyOptions(event.id, event.options)))
        : emit(PopMenuOptionsErrorState(
            message: response.error?.message ?? 'Unexpected Error'));
  }

  List<PopMenuVerifiedOptionContract> _verifyOptions(
      String id, List<PopMenuOptionsTypeEnum> options) {
    return options.map((item) {
      final response = persistentContentRepositoryImpl.containBadge(id, item);

      return PopMenuVerifiedOptionContract(
        type: item,
        isActive: response.hasError ? false : response.success!,
      );
    }).toList();
  }
}
