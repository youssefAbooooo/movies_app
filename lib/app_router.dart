import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/views/home_screen.dart';
import 'package:movies_app/views/login_screen.dart';
import 'package:movies_app/views/movie_detail_screen.dart';
import 'package:movies_app/views/splash_screen.dart';
import 'package:movies_app/views/watchlist_screen.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.id:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case LoginScreen.id:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case HomeScreen.id:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case MovieDetailScreen.id:
        final movie = settings.arguments as Movie;
        return MaterialPageRoute(
            builder: (_) => MovieDetailScreen(movie: movie));
      case WatchlistScreen.id:
        return MaterialPageRoute(builder: (_) => WatchlistScreen());
      default:
        return null;
    }
  }
}
