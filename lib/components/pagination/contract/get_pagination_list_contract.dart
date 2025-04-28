import 'package:flufflix/components/pagination/contract/index.dart';

abstract class GetPaginationListContract<E extends PaginationCardContract> {
  final int page;
  final bool isFirst;
  final bool isLast;
  final List<E> list;

  const GetPaginationListContract(
      {required this.page,
      required this.isFirst,
      required this.isLast,
      required this.list});
}
