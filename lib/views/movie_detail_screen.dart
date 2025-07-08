import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/app_colors.dart';
import 'package:movies_app/cubits/get_movie_details_cubit/movie_details_cubit.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/widgets/datails_screen_app_bar.dart';
import 'package:movies_app/widgets/movie_details_content.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key, required this.movie});

  static const String id = '/movieDetailScreen';
  final Movie movie;

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void initState() {
    BlocProvider.of<GetMovieDetailsCubit>(context)
        .getMovieDetails(widget.movie.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          DetailsScreenAppBar(
            title: widget.movie.title,
            poster: widget.movie.poster,
          ),
          BlocBuilder<GetMovieDetailsCubit, GetMovieDetailsState>(
            builder: (context, state) {
              if (state is GetMovieDetailsLoaded) {
                return MovieDetailsContent(movie: state.movie);
              } else if (state is GetMovieDetailsLoading) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                );
              } else if (state is GetMovieDetailsError) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text('Error: ${state.error}'),
                  ),
                );
              } else {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text('Error getting movie details.'),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
