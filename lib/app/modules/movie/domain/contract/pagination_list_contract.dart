import 'package:flufflix/app/modules/movie/domain/contract/pagination_card_contract.dart';

class PaginationListContract {
  final int page;
  final bool isFirst;
  final bool isLast;
  final List<PaginationCardContract> list;

  const PaginationListContract(
      {required this.page,
      required this.isFirst,
      required this.isLast,
      required this.list});
}
