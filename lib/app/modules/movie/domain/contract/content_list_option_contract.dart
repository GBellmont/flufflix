import 'package:flufflix/app/modules/movie/domain/contract/contracts.dart';
import 'package:flufflix/app/modules/movie/presentation/enum/enums.dart';

class ContentListOptionContract {
  final String id;
  final String title;
  final List<ContentListItemContract> localContent;
  final ContentListFetchTypeEnum? typeToFetch;

  const ContentListOptionContract({
    required this.id,
    required this.title,
    this.typeToFetch,
    this.localContent = const [],
  });
}
