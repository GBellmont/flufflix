import 'package:flufflix/app/modules/content/domain/contract/contracts.dart';
import 'package:flufflix/app/modules/content/presentation/enum/enums.dart';

sealed class ContentListEvent {}

class FecthContentListData extends ContentListEvent {
  final List<ContentListItemContract> localContent;
  final ContentListFetchTypeEnum? type;
  final String id;
  final String? seasonId;

  FecthContentListData(
      {required this.id,
      this.type,
      this.localContent = const [],
      this.seasonId});
}
