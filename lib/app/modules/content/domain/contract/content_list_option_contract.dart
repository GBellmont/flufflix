import 'package:flufflix/app/modules/content/domain/contract/contracts.dart';
import 'package:flufflix/app/modules/content/presentation/enum/enums.dart';

class ContentListOptionContract {
  final String id;
  final String title;
  final List<ContentListItemContract> localContent;
  final ContentListFetchTypeEnum? typeToFetch;
  final String? seasonNumber;

  const ContentListOptionContract(
      {required this.id,
      required this.title,
      this.typeToFetch,
      this.localContent = const [],
      this.seasonNumber});
}
