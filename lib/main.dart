import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/app_colors.dart';
import 'package:movies_app/cubits/get_movies_cubit/get_movies_cubit.dart';
import 'package:movies_app/cubits/get_tv_series_cubit/get_tv_series_cubit.dart';
import 'package:movies_app/simple_bloc_observer.dart';
import 'package:movies_app/views/login_screen.dart';
import 'package:movies_app/views/splash_screen.dart';

import 'views/home_screen.dart';
import 'views/movie_detail_screen.dart';
import 'views/watchlist_screen.dart';

void main() {
  //adding bloc observer to observe cubits
  Bloc.observer = SimpleBlocObserver();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<GetMoviesCubit>(
          create: (context) => GetMoviesCubit(),
        ),
        BlocProvider<GetTvSeriesCubit>(
          create: (context) => GetTvSeriesCubit(),
        ),
      ],
      child: const MoviesApp(),
    ),
  );
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        MovieDetailScreen.id: (context) => MovieDetailScreen(),
        WatchlistScreen.id: (context) => WatchlistScreen(),
      },
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.textPrimary,
        ),
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
