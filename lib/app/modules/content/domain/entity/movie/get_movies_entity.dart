import 'package:flufflix/app/modules/content/domain/entity/entities.dart';

abstract class GetMoviesEntity<T extends MovieEntity> {
  final int page;
  final bool isFirst;
  final bool isLast;
  final List<T> list;

  const GetMoviesEntity(
      {required this.page,
      required this.isFirst,
      required this.isLast,
      required this.list});
}
