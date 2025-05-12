import 'package:flufflix/app/modules/content/presentation/enum/enums.dart';

class PaginationCardContract {
  final int id;
  final String title;
  final String imagePath;
  final ContentTypeEnum type;

  const PaginationCardContract(
      {required this.id,
      required this.title,
      required this.imagePath,
      required this.type});
}
