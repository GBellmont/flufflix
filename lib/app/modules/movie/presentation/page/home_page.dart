import 'package:flutter/material.dart';

import 'package:flufflix/app/modules/movie/presentation/widget/widgets.dart';
import 'package:flufflix/app/modules/movie/presentation/enum/enums.dart';

class HomePage extends StatelessWidget {
  static const String route = '/home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset(
            "assets/images/madame_web_banner.png",
            fit: BoxFit.contain,
            height: 515,
            width: double.infinity,
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 15, top: 20),
            child: PaginationList(
              type: PaginationListTypeEnum.popularMovies,
              listTitle: 'Popular Movies',
              fetchListErrorMessage: 'Error loading popular movies',
            ),
          ),
          const PaginationList(
            type: PaginationListTypeEnum.topRatedMovies,
            listTitle: 'Top Rated Movies',
            fetchListErrorMessage: 'Error loading top rated movies',
          )
        ],
      ),
    );
  }
}
