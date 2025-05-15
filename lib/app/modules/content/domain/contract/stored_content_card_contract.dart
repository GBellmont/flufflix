import 'package:flufflix/app/modules/content/presentation/enum/enums.dart';
import 'package:flufflix/app/modules/shared/presentation/enum/enums.dart';

class StoredContentCardContract {
  final String id;
  final String title;
  final String imagePath;
  final String releaseYear;
  final ContentTypeEnum type;
  final List<PopMenuOptionsTypeEnum> badges;

  StoredContentCardContract(
      {required this.id,
      required this.title,
      required this.imagePath,
      required this.releaseYear,
      required this.type,
      required this.badges});
}
