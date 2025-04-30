import 'package:flutter/material.dart';

import 'package:flufflix/components/pagination/index.dart';
import 'package:flufflix/core/models/index.dart';
import 'package:flufflix/core/repositories/index.dart';
import 'package:flufflix/core/repositories/response/index.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  late final MovieRepository movieRepository;

  @override
  void initState() {
    movieRepository = MovieRepository();
    super.initState();
  }

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
          Padding(
            padding: const EdgeInsets.only(bottom: 15, top: 20),
            child: PaginationList<Movie, GetPopularMoviesResponse>(
              getPaginationList: movieRepository.getPopularMovies,
              listTitle: 'Popular Movies',
              fetchListErrorMessage: 'Error loading popular movies',
            ),
          ),
          PaginationList<Movie, GetTopRatedMoviesResponse>(
            getPaginationList: movieRepository.getTopRatedMovies,
            listTitle: 'Top Rated Movies',
            fetchListErrorMessage: 'Error loading top rated movies',
          )
        ],
      ),
    );
  }
}
