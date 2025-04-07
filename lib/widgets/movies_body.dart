import 'package:flutter/material.dart';

import '../cubits/get_movies_cubit/get_movies_cubit.dart';
import 'movie_category.dart';

class MoviesBody extends StatelessWidget {
  const MoviesBody({
    super.key,
    required this.state,
  });

  final MoviesLoaded state;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 32,
      children: [
        MovieCategory(
          title: 'Popular',
          movies: state.popularMovies,
        ),
        MovieCategory(
          title: 'Now Playing',
          movies: state.nowPlayingMovies,
        ),
        MovieCategory(
          title: 'Top Rated',
          movies: state.topRatedMovies,
        ),
        MovieCategory(
          title: 'Upcoming',
          movies: state.upcomingMovies,
        ),
      ],
    );
  }
}
