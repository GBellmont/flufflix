import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flufflix/app/modules/movie/presentation/event/events.dart';
import 'package:flufflix/app/modules/movie/presentation/widget/widgets.dart';
import 'package:flufflix/app/core/injection/injections.dart';
import 'package:flufflix/app/modules/movie/presentation/bloc/blocs.dart';
import 'package:flufflix/app/modules/movie/presentation/enum/enums.dart';
import 'package:flufflix/app/modules/movie/presentation/state/states.dart';

class PaginationList extends StatefulWidget {
  final PaginationListTypeEnum type;
  final String fetchListErrorMessage;
  final String listTitle;

  const PaginationList(
      {super.key,
      required this.type,
      required this.listTitle,
      required this.fetchListErrorMessage});

  @override
  State<StatefulWidget> createState() => _PaginationListState();
}

class _PaginationListState extends State<PaginationList> {
  late final PaginationBloc _paginationBloc;

  @override
  void initState() {
    _paginationBloc = getIt.get<PaginationBloc>();
    _paginationBloc.init(widget.type);

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
                      PaginationSuccessState(data: var responseData) =>
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
                    });
              }),
        ],
      ),
    );
  }
}
