import 'package:flufflix/components/content/contract/index.dart';

sealed class ContentListEvent {}

class FecthContentListData<T extends ContentListItemContract>
    extends ContentListEvent {
  final Future<List<T>> Function() fecthFunctionData;

  FecthContentListData({required this.fecthFunctionData});
}
