import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/cubits/get_movie_details_cubit/movie_details_cubit.dart';
import 'package:movies_app/cubits/get_my_watchlist_cubit/get_my_watchlist_cubit.dart';
import 'package:movies_app/cubits/get_tvseries_details_cubit/get_tvseries_details_cubit.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/models/tv_series.dart';
import 'package:movies_app/views/home_screen.dart';
import 'package:movies_app/views/login_screen.dart';
import 'package:movies_app/views/movie_detail_screen.dart';
import 'package:movies_app/views/page_not_found_screen.dart';
import 'package:movies_app/views/splash_screen.dart';
import 'package:movies_app/views/tv_series_detail_screen.dart';
import 'package:movies_app/views/watchlist_screen.dart';
import 'package:movies_app/views/webview_approval_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case SplashScreen.id:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case LoginScreen.id:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case TMDBWebViewPage.id:
        final String requestToken = arguments as String;
        return MaterialPageRoute(
            builder: (_) => TMDBWebViewPage(requestToken: requestToken));
      case HomeScreen.id:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case MovieDetailsScreen.id:
        final Movie movie = arguments as Movie;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => GetMovieDetailsCubit(),
            child: MovieDetailsScreen(movie: movie),
          ),
        );
      case WatchlistScreen.id:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => GetMyWatchlistCubit(),
                  child: WatchlistScreen(),
                ));
      case TvSeriesDetailScreen.id:
        final TvSeries tvSeries = arguments as TvSeries;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => GetTvseriesDetailsCubit(),
                  child: TvSeriesDetailScreen(tvSeries: tvSeries),
                ));
      default:
        return MaterialPageRoute(builder: (_) => PageNotFoundScreen());
    }
  }
}
