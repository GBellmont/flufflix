import 'package:flufflix/components/content/contract/index.dart';
import 'package:flufflix/components/content/index.dart';
import 'package:flufflix/core/blocs/index.dart';
import 'package:flufflix/core/constants/index.dart';
import 'package:flufflix/core/events/content/content_list_event.dart';
import 'package:flufflix/core/states/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContentOptions<T extends ContentListItemContract> {
  final String name;
  final Future<List<T>> Function() fetchContentData;

  ContentOptions({
    required this.name,
    required this.fetchContentData,
  });
}

class ContentList<T extends ContentListItemContract> extends StatefulWidget {
  final String title;
  final List<ContentOptions<T>> options;

  const ContentList({super.key, required this.options, required this.title});

  @override
  State<StatefulWidget> createState() => _ContentListState<T>();
}

class _ContentListState<T extends ContentListItemContract>
    extends State<ContentList<T>> {
  late final ContentListBloc<T> _contentListBloc;

  @override
  void initState() {
    _contentListBloc = ContentListBloc<T>();

    if (widget.options.isNotEmpty) {
      _contentListBloc.add(FecthContentListData<T>(
          fecthFunctionData: widget.options[0].fetchContentData));
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
                        _contentListBloc.add(FecthContentListData<T>(
                            fecthFunctionData:
                                widget.options[index].fetchContentData));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(),
                        child: Text(
                          widget.options[index].name,
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
                  case ContentListSuccessState<ContentListItemContract>(
                      contentList: var list
                    ):
                    {
                      if (list.isEmpty) {
                        return Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.amber, width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            height: 100,
                            width: double.infinity,
                            child: const Column(
                              children: [
                                Icon(
                                  Icons.warning_outlined,
                                  color: Colors.amber,
                                  size: 50,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    'No Items Found',
                                    style: TextStyle(color: Colors.amber),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return _ContentItem(item: list[index]);
                        },
                        itemCount: list.length,
                      );
                    }
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
  final ContentListItemContract item;

  const _ContentItem({required this.item});

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
              '${EnvConstants.instance.baseImagesUrl}/w300${item.image}',
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
