import 'package:flufflix/app/modules/content/domain/contract/contracts.dart';

abstract class ListContentListItemInterface {
  List<ContentListItemContract> toListContentListItemContract();
}

abstract class ContentListItemInterface {
  ContentListItemContract toContentListItemContract();
}
