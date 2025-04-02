import 'package:flutter/material.dart';

import 'views/home_screen.dart';
import 'views/movie_detail_screen.dart';
import 'views/watchlist_screen.dart';

void main() {
  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'HomeScreen': (context) => HomeScreen(),
        'MovieDetailScreen': (context) => MovieDetailScreen(),
        'WatchlistScreen': (context) => WatchlistScreen(),
      },
    );
  }
}
