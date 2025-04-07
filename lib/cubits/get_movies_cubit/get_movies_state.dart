part of 'get_movies_cubit.dart';

@immutable
sealed class GetMoviesState {}

final class MoviesInitial extends GetMoviesState {}

final class MoviesLoading extends GetMoviesState {}

final class MoviesLoaded extends GetMoviesState {
  final List<Movie> nowPlayingMovies;
  final List<Movie> popularMovies;
  final List<Movie> topRatedMovies;
  final List<Movie> upcomingMovies;

  MoviesLoaded({
    required this.nowPlayingMovies,
    required this.popularMovies,
    required this.topRatedMovies,
    required this.upcomingMovies,
  });
}

final class MoviesError extends GetMoviesState {
  final String message;

  MoviesError(this.message);
}
