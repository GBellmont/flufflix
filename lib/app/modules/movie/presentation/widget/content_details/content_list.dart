import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flufflix/app/core/config/configs.dart';
import 'package:flufflix/app/core/injection/injections.dart';

import 'package:flufflix/app/modules/movie/domain/contract/contracts.dart';
import 'package:flufflix/app/modules/movie/presentation/bloc/blocs.dart';
import 'package:flufflix/app/modules/movie/presentation/state/states.dart';
import 'package:flufflix/app/modules/movie/presentation/event/events.dart';
import 'package:flufflix/app/modules/movie/presentation/widget/widgets.dart';

class ContentList extends StatefulWidget {
  final String contentId;
  final String title;
  final String defaultImage;
  final List<ContentListOptionContract> options;

  const ContentList(
      {super.key,
      required this.options,
      required this.title,
      required this.contentId,
      required this.defaultImage});

  @override
  State<StatefulWidget> createState() => _ContentListState();
}

class _ContentListState extends State<ContentList> {
  late final ContentListBloc _contentListBloc;

  @override
  void initState() {
    _contentListBloc = getIt.get<ContentListBloc>();

    if (widget.options.isNotEmpty) {
      _contentListBloc.add(FecthContentListData(
          id: widget.options[0].id,
          type: widget.options[0].typeToFetch,
          localContent: widget.options[0].localContent));
    }

    super.initState();
  }

  @override
  void dispose() {
    _contentListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              widget.title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SizedBox(
              height: 30,
              width: double.infinity,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                      ),
                      onPressed: () {
                        _contentListBloc.add(FecthContentListData(
                            id: widget.options[index].id,
                            type: widget.options[index].typeToFetch,
                            localContent: widget.options[index].localContent));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(),
                        child: Text(
                          widget.options[index].title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 14),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        width: 15,
                      ),
                  itemCount: widget.options.length),
            ),
          ),
          BlocBuilder<ContentListBloc, ContentListState>(
              bloc: _contentListBloc,
              builder: (context, state) {
                switch (state) {
                  case ContentListInitialState():
                    return const ContentListLoading();
                  case ContentListLoadingState():
                    return const ContentListLoading();
                  case ContentListSuccessState(contentList: var list):
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return _ContentItem(
                          item: list[index],
                          defaultImage: widget.defaultImage,
                        );
                      },
                      itemCount: list.length,
                    );
                  case ContentListErrorState():
                    return const SizedBox.shrink();
                }
              })
        ],
      ),
    );
  }
}

class _ContentItem extends StatelessWidget {
  final String defaultImage;
  final ContentListItemContract item;

  const _ContentItem({required this.item, required this.defaultImage});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            height: 100,
            child: Image.network(
              '${AppConfig.instance.baseImagesUrl}/w300${item.image ?? defaultImage}',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: size.width * .35,
                      child: Text(
                        item.title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Text(
                      item.runtime,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w100,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    item.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 13,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
