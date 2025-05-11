import 'package:flufflix/app/modules/content/domain/entity/entities.dart';

abstract class GetSeriesEntity<T extends SerieEntity> {
  final int page;
  final bool isFirst;
  final bool isLast;
  final List<T> list;

  const GetSeriesEntity(
      {required this.page,
      required this.isFirst,
      required this.isLast,
      required this.list});
}
