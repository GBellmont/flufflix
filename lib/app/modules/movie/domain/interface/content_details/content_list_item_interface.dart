import 'package:flufflix/app/modules/movie/domain/contract/contracts.dart';

abstract class ListContentListItemInterface {
  List<ContentListItemContract> toListContentListItemContract();
}

abstract class ContentListItemInterface {
  ContentListItemContract toContentListItemContract();
}
