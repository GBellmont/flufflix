import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:flufflix/app/core/injection/injections.dart';
import 'package:flufflix/app/core/config/configs.dart';

import 'package:flufflix/app/modules/shared/presentation/enum/enums.dart';
import 'package:flufflix/app/modules/shared/presentation/widget/widgets.dart';
import 'package:flufflix/app/modules/content/presentation/enum/enums.dart';
import 'package:flufflix/app/modules/content/presentation/widget/widgets.dart';
import 'package:flufflix/app/modules/content/presentation/bloc/blocs.dart';
import 'package:flufflix/app/modules/content/presentation/event/events.dart';
import 'package:flufflix/app/modules/content/presentation/state/states.dart';

class ContentDetailsPage extends StatefulWidget {
  static const String route = '/content-details/:id';

  final String id;
  final String title;
  final String posterImage;
  final String releaseYear;
  final ContentTypeEnum type;

  const ContentDetailsPage(
      {super.key,
      required this.id,
      required this.title,
      required this.posterImage,
      required this.releaseYear,
      required this.type});

  static String buildRoute(String id) {
    return route.replaceFirst(':id', id);
  }

  @override
  State<StatefulWidget> createState() => _ContentDetailsPageState();
}

class _ContentDetailsPageState extends State<ContentDetailsPage> {
  late final ContentDetailsBloc _contentBloc;
  late final StreamSubscription<ContentDetailsState> _contentDetailsStateSub;

  @override
  void initState() {
    _contentBloc = getIt.get<ContentDetailsBloc>();
    _contentDetailsStateSub =
        _contentBloc.stream.listen(contentDetailsStateListener);

    _contentBloc.add(GetContentEvent(contentId: widget.id, type: widget.type));
    super.initState();
  }

  @override
  void dispose() {
    _contentDetailsStateSub.cancel();
    _contentBloc.close();
    super.dispose();
  }

  void contentDetailsStateListener(ContentDetailsState state) {
    if (state is ContentDetailsErrorState) {
      ScaffoldMessenger.of(context).showSnackBar(
          StyledSnackBar(text: state.message, type: StyledSnackBarType.error));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
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
                  PopMenuButton(
                    id: widget.id,
                    title: widget.title,
                    posterImage: widget.posterImage,
                    releaseYear: widget.releaseYear,
                    type: widget.type,
                    options: const [
                      PopMenuOptionsTypeEnum.favorite,
                      PopMenuOptionsTypeEnum.download
                    ],
                  )
                ],
              ),
            ),
          ),
          BlocBuilder<ContentDetailsBloc, ContentDetailsState>(
            bloc: _contentBloc,
            builder: (context, state) {
              switch (state) {
                case ContentDetailsInitialState():
                case ContentDetailsLoadingState():
                  return const SliverToBoxAdapter(
                      child: ContentDetailsLoading());
                case ContentDetailsSuccessState(data: var contentContract):
                  return SliverList(
                    delegate: SliverChildListDelegate([
                      Image.network(
                        '${AppConfig.instance.baseImagesUrl}/w1280${contentContract.bannerImage}',
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
                              options: contentContract.contentList,
                            ),
                          ],
                        ),
                      ),
                    ]),
                  );
                default:
                  return const SliverToBoxAdapter(child: SizedBox.shrink());
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
