import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/cubits/get_movies_cubit/get_movies_cubit.dart';

import '../widgets/category_section.dart';
import '../widgets/home_app_bar.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: HomeAppBar(),
        body: BlocBuilder<GetMoviesCubit, GetMoviesState>(
          builder: (context, state) {
            if (state is MoviesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is MoviesLoaded) {
              return SingleChildScrollView(
                child: Column(
                  spacing: 32,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CategorySection(
                      title: 'Popular',
                      movies: state.popularMovies,
                    ),
                    CategorySection(
                      title: 'Now Playing',
                      movies: state.nowPlayingMovies,
                    ),
                    CategorySection(
                      title: 'Top Rated',
                      movies: state.topRatedMovies,
                    ),
                    CategorySection(
                      title: 'Upcoming',
                      movies: state.upcomingMovies,
                    ),
                  ],
                ),
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
      ),
    );
  }
}
