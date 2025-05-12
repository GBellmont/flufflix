import 'package:flufflix/app/core/injection/injections.dart';
import 'package:flufflix/app/modules/content/presentation/state/stored_content_state.dart';
import 'package:flufflix/app/modules/content/presentation/store/stores.dart';
import 'package:flufflix/app/modules/content/presentation/widget/widgets.dart';
import 'package:flutter/material.dart';

class StoredContentPage extends StatefulWidget {
  static const String route = '/stored-content';

  const StoredContentPage({super.key});

  @override
  State<StatefulWidget> createState() => _StoredContentPageState();
}

class _StoredContentPageState extends State<StoredContentPage> {
  late final StoredContentStore _storedContentStore;

  @override
  void initState() {
    _storedContentStore = getIt.get<StoredContentStore>();
    _storedContentStore.updateContentList();

    super.initState();
  }

  @override
  void dispose() {
    _storedContentStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: Center(
                child: Text(
                  'Stored Content',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              height: 8,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black54,
                    Colors.black12,
                  ],
                ),
              ),
            ),
          ),
          ValueListenableBuilder(
              valueListenable: _storedContentStore.state,
              builder: (context, value, child) => switch (value) {
                    StoredContentInitialState() => const StoredContentLoading(),
                    StoredContentLoadingState() => const StoredContentLoading(),
                    StoredContentSuccessState() => SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (_, index) => StoredContentCard(
                            item: value.list[index],
                            updateList: () {
                              _storedContentStore.updateContentList();
                            },
                          ),
                          childCount: value.list.length,
                        ),
                      ),
                    StoredContentErrorState() => const SizedBox.shrink()
                  })
        ],
      ),
    );
  }
}
