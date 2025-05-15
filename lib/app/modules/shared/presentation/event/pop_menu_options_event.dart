import 'package:flufflix/app/modules/content/presentation/enum/enums.dart';
import 'package:flufflix/app/modules/shared/presentation/enum/enums.dart';

sealed class PopMenuOptionsEvent {}

class VerifyOptionsStateEvent extends PopMenuOptionsEvent {
  final String id;
  final List<PopMenuOptionsTypeEnum> options;

  VerifyOptionsStateEvent({required this.id, required this.options});
}

class ExecuteOptionActionEvent extends PopMenuOptionsEvent {
  final String id;
  final String title;
  final String posterImage;
  final String releaseYear;
  final ContentTypeEnum type;
  final bool activate;
  final PopMenuOptionsTypeEnum typeToExecuteAction;
  final List<PopMenuOptionsTypeEnum> options;

  ExecuteOptionActionEvent(
      {required this.id,
      required this.title,
      required this.posterImage,
      required this.releaseYear,
      required this.type,
      required this.activate,
      required this.typeToExecuteAction,
      required this.options});
}
