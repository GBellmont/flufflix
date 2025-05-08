import 'package:flufflix/core/blocs/pagination/pagination_bloc.dart';
import 'package:flufflix/core/events/pagination/pagination_event.dart';
import 'package:flufflix/core/states/pagination/pagination_state.dart';
import 'package:flutter/material.dart';

import 'package:flufflix/components/buttons/index.dart';
import 'package:flufflix/components/pagination/contract/index.dart';
import 'package:flufflix/components/pagination/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  late final PaginationBloc<T> _paginationBloc;

  @override
  void initState() {
    _paginationBloc =
        PaginationBloc<T>(getPaginationList: widget.getPaginationList);
    _paginationBloc.add(FetchPaginationListEvent(page: 1));

    super.initState();
  }

  @override
  void dispose() {
    _paginationBloc.close();
    super.dispose();
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
          BlocBuilder<PaginationBloc, PaginationState>(
              bloc: _paginationBloc,
              builder: (context, state) {
                return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: switch (state) {
                      PaginationInitialState() => const PaginationLoadingList(),
                      PaginationLoadingState() => const PaginationLoadingList(),
                      PaginationErrorState(pageToRetrie: var page) =>
                        PaginationListError(
                          onRetry: () => _paginationBloc
                              .add(FetchPaginationListEvent(page: page)),
                          message: widget.fetchListErrorMessage,
                        ),
                      PaginationSuccessState<T>(data: T responseData) =>
                        SizedBox(
                          height: 180,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 10),
                            itemCount: responseData.list.length +
                                (!responseData.isFirst ? 1 : 0) +
                                (!responseData.isLast ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (!responseData.isFirst && index == 0) {
                                return PaginationButton(
                                  onPressed: () => _paginationBloc.add(
                                      FetchPaginationListEvent(
                                          page: responseData.page - 1)),
                                );
                              }

                              if (!responseData.isLast &&
                                  index ==
                                      responseData.list.length +
                                          (!responseData.isFirst ? 1 : 0)) {
                                return PaginationButton(
                                  onPressed: () => _paginationBloc.add(
                                      FetchPaginationListEvent(
                                          page: responseData.page + 1)),
                                  right: true,
                                );
                              }

                              return PaginationCard(
                                item: responseData.list[
                                    index - (!responseData.isFirst ? 1 : 0)],
                              );
                            },
                          ),
                        ),
                      _ => const SizedBox.shrink()
                    });
              }),
        ],
      ),
    );
  }
}
