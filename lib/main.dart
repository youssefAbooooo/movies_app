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
      // initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        MovieDetailScreen.id: (context) => MovieDetailScreen(),
        WatchlistScreen.id: (context) => WatchlistScreen(),
      },
    );
  }
}
