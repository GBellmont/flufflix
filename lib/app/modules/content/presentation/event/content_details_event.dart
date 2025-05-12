import 'package:flufflix/app/modules/content/presentation/enum/enums.dart';

sealed class ContentDetailsEvent {
  final String contentId;
  final ContentTypeEnum type;

  const ContentDetailsEvent({required this.contentId, required this.type});
}

class GetContentEvent extends ContentDetailsEvent {
  GetContentEvent({required super.contentId, required super.type});
}
