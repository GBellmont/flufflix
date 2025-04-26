import 'package:flufflix/components/buttons/index.dart';
import 'package:flufflix/components/pagination/contract/index.dart';
import 'package:flufflix/components/pagination/index.dart';
import 'package:flutter/material.dart';

enum PaginationListState {
  empty,
  loading,
  error,
  success;
}

class PaginationList<E extends PaginationCardContract,
    T extends GetPaginationListContract<E>> extends StatefulWidget {
  final Future<T> Function({int? page}) getPaginationList;
  final String fetchListErrorMessage;
  final String listTitle;

  const PaginationList(
      {super.key,
      required this.getPaginationList,
      required this.listTitle,
      required this.fetchListErrorMessage});

  @override
  State<StatefulWidget> createState() => _PaginationList();
}

class _PaginationList<E extends PaginationCardContract,
        T extends GetPaginationListContract<E>>
    extends State<PaginationList<E, T>> {
  List<E> _list = [];
  int _page = 1;
  bool _isFirst = false;
  bool _isLast = true;
  PaginationListState _state = PaginationListState.empty;

  @override
  void initState() {
    super.initState();

    _fecthList(_page);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _fecthList(int page) async {
    setState(() {
      _state = PaginationListState.loading;
    });

    try {
      final listResponse = await widget.getPaginationList(page: page);

      setState(() {
        _list = listResponse.list;
        _state = PaginationListState.success;
        _isFirst = listResponse.isFirst;
        _isLast = listResponse.isLast;
        _page = listResponse.page;
      });
    } catch (e) {
      setState(() {
        _state = PaginationListState.error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 12),
            child: Text(
              widget.listTitle,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
          ),
          if (_state == PaginationListState.empty ||
              _state == PaginationListState.loading)
            const PaginationLoadingList()
          else if (_state == PaginationListState.error)
            PaginationListError(
              onRetry: () => _fecthList(_page),
              message: widget.fetchListErrorMessage,
            )
          else
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      _list.length + (!_isFirst ? 1 : 0) + (!_isLast ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (!_isFirst && index == 0) {
                      return PaginationButton(
                        onPressed: () => _fecthList(_page - 1),
                      );
                    }

                    if (!_isLast &&
                        index == _list.length + (!_isFirst ? 1 : 0)) {
                      return PaginationButton(
                        onPressed: () => _fecthList(_page + 1),
                        right: true,
                      );
                    }

                    return PaginationCard(
                      item: _list[index - (!_isFirst ? 1 : 0)],
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
