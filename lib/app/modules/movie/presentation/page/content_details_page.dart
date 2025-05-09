import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:flufflix/app/core/injection/injections.dart';
import 'package:flufflix/app/core/config/configs.dart';

import 'package:flufflix/app/modules/shared/presentation/domain/contract/contracts.dart';
import 'package:flufflix/app/modules/shared/presentation/widget/widgets.dart';

import 'package:flufflix/app/modules/movie/domain/contract/contracts.dart';
import 'package:flufflix/app/modules/movie/presentation/enum/enums.dart';
import 'package:flufflix/app/modules/movie/presentation/widget/widgets.dart';
import 'package:flufflix/app/modules/movie/presentation/bloc/blocs.dart';
import 'package:flufflix/app/modules/movie/presentation/event/events.dart';
import 'package:flufflix/app/modules/movie/presentation/state/states.dart';

class ContentDetailsPage extends StatefulWidget {
  static const String route = '/content-details/:id';

  final String id;
  final String title;
  final String posterImage;

  const ContentDetailsPage({
    super.key,
    required this.id,
    required this.title,
    required this.posterImage,
  });

  static String buildRoute(String id) {
    return route.replaceFirst(':id', id);
  }

  @override
  State<StatefulWidget> createState() => _ContentDetailsPageState();
}

class _ContentDetailsPageState extends State<ContentDetailsPage> {
  late final ContentDetailsBloc _contentBloc;

  @override
  void initState() {
    _contentBloc = getIt.get<ContentDetailsBloc>();

    _contentBloc.add(GetMovieContentEvent(contentId: widget.id));

    super.initState();
  }

  @override
  void dispose() {
    _contentBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(right: 10, left: 4, top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  Flexible(
                      child: _TitleText(text: widget.title, ellipsis: true)),
                  PopMenuButton(options: [
                    PopMenuOptionContract(
                      value: 'favorite',
                      text: 'Favorite',
                      action: () async => log("tap -> favorite"),
                    ),
                    PopMenuOptionContract(
                      value: 'download',
                      text: 'Download',
                      action: () async => log("tap -> download"),
                    )
                  ])
                ],
              ),
            ),
          ),
          BlocBuilder<ContentDetailsBloc, ContentDetailsState>(
            bloc: _contentBloc,
            builder: (context, state) {
              switch (state) {
                case ContentInitialState():
                case ContentLoadingState():
                  return const SliverToBoxAdapter(
                      child: ContentDetailsLoading());
                case ContentErrorState():
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        'Erro ao carregar conteúdo',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                case ContentSuccessState(data: var contentContract):
                  return SliverList(
                    delegate: SliverChildListDelegate([
                      Image.network(
                        '${AppConfig.instance.baseImagesUrl}/original${contentContract.bannerImage}',
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey,
                          height: size.height * .25,
                        ),
                        fit: BoxFit.cover,
                        height: size.height * .25,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _TitleText(text: contentContract.title),
                            _TagsText(text: contentContract.tags),
                            if (contentContract.description.isNotEmpty)
                              _DescriptionText(
                                  text: contentContract.description),
                            _CategoryText(
                                text: 'Starring: ${contentContract.starring}'),
                            _CategoryText(
                                text: 'Directors: ${contentContract.creators}'),
                            _CategoryText(
                                text: 'Genres: ${contentContract.genres}'),
                            const SizedBox(height: 25),
                            ContentList(
                              contentId: widget.id,
                              defaultImage: contentContract.bannerImage,
                              title: 'Videos',
                              options: [
                                ContentListOptionContract(
                                    title: 'Content',
                                    localContent: [
                                      ContentListItemContract(
                                        title: 'Movie',
                                        description:
                                            'Complete movie in HD resolution',
                                        runtime:
                                            "${contentContract.runtime}min",
                                      )
                                    ]),
                                const ContentListOptionContract(
                                    title: 'Additionals',
                                    typeToFetch:
                                        ContentListFetchTypeEnum.movieTrailers),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ]),
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _TitleText extends StatelessWidget {
  final String text;
  final bool ellipsis;

  const _TitleText({required this.text, this.ellipsis = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: ellipsis ? TextOverflow.ellipsis : TextOverflow.visible,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w900,
        fontSize: 20,
      ),
    );
  }
}

class _TagsText extends StatelessWidget {
  final String text;

  const _TagsText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w100,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _DescriptionText extends StatelessWidget {
  final String text;

  const _DescriptionText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }
}

class _CategoryText extends StatelessWidget {
  final String text;

  const _CategoryText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w300,
          fontSize: 13,
        ),
      ),
    );
  }
}
