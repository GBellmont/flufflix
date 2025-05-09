import 'package:flufflix/app/modules/movie/domain/contract/contracts.dart';
import 'package:flufflix/app/modules/movie/presentation/enum/enums.dart';

sealed class ContentListEvent {}

class FecthContentListData extends ContentListEvent {
  final List<ContentListItemContract> localContent;
  final ContentListFetchTypeEnum? type;
  final String id;

  FecthContentListData(
      {required this.id, this.type, this.localContent = const []});
}
