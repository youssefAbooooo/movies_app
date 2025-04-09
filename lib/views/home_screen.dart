import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/app_colors.dart';
import 'package:movies_app/cubits/get_movies_cubit/get_movies_cubit.dart';
import 'package:movies_app/widgets/tv_series_body.dart';

import '../cubits/get_tv_series_cubit/get_tv_series_cubit.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/movies_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static String id = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetMoviesCubit>(context).getMovies();
    BlocProvider.of<GetTvSeriesCubit>(context).getTvSeries();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: HomeAppBar(),
          body: SingleChildScrollView(
            child: Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 16),
                  child: Text(
                    'Movies',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                BlocBuilder<GetMoviesCubit, GetMoviesState>(
                  builder: (context, state) {
                    if (state is MoviesLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is MoviesLoaded) {
                      return SingleChildScrollView(
                        child: MoviesBody(state: state),
                      );
                    } else if (state is MoviesError) {
                      return Center(
                        child: Text('Error: ${state.message}'),
                      );
                    } else {
                      return Center(
                        child: Text('Load movies'),
                      );
                    }
                  },
                ),
                SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 16),
                  child: Text(
                    'TV Series',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                BlocBuilder<GetTvSeriesCubit, GetTvSeriesState>(
                  builder: (context, state) {
                    if (state is TvSeriesLoading) {
                      return Center(
                          child: CircularProgressIndicator(
                              color: AppColors.details));
                    } else if (state is TvSeriesLoaded) {
                      return SingleChildScrollView(
                        child: TvSeriesBody(state: state),
                      );
                    } else if (state is TvSeriesError) {
                      return Center(
                        child: Text('Error: ${state.message}'),
                      );
                    } else {
                      return Center(
                        child: Text('Load movies'),
                      );
                    }
                  },
                ),
                SizedBox(height: 20)
              ],
            ),
          )),
    );
  }
}
