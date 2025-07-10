import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/app_colors.dart';
import 'package:movies_app/app_router.dart';
import 'package:movies_app/cubits/get_my_watchlist_cubit/get_my_watchlist_cubit.dart';
import 'package:movies_app/cubits/watchlist_cubit/watchlist_cubit_cubit.dart';
import 'package:movies_app/services/account_datails_service.dart';
import 'package:movies_app/simple_bloc_observer.dart';
import 'package:movies_app/views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialize the get session_id service
  await AccountDetailsService().init();
  //adding bloc observer to observe cubits
  Bloc.observer = SimpleBlocObserver();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetMyWatchlistCubit(),
        ),
        BlocProvider(
          create: (context) => WatchlistCubit(),
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
      initialRoute: SplashScreen.id,
      onGenerateRoute: AppRouter.generateRoute,
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
