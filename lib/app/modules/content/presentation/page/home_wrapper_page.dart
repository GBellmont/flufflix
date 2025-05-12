import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flufflix/app/modules/content/presentation/page/pages.dart';

final tabs = [
  HomePage.route,
  '/search',
  StoredContentPage.route,
  '/config',
];

class HomeWrapperPage extends StatefulWidget {
  final Widget child;
  final int index;

  const HomeWrapperPage({required this.child, required this.index, super.key});

  @override
  State<StatefulWidget> createState() => _HomeWrapperPageState();
}

class _HomeWrapperPageState extends State<HomeWrapperPage> {
  void changePage(int index) {
    final route = tabs[index];
    if (!context.mounted) return;
    context.go(route, extra: index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: widget.child),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.index,
        onTap: (value) => changePage(value),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        fixedColor: Colors.green,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.archive), label: 'Stored'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
        ],
      ),
    );
  }
}
