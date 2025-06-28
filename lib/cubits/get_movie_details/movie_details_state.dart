part of 'movie_details_cubit.dart';

@immutable
sealed class GetMovieDetailsState {}

final class GetMovieDetailsInitial extends GetMovieDetailsState {}

final class GetMovieDetailsLoaded extends GetMovieDetailsState {
  final Movie movie;

  GetMovieDetailsLoaded({required this.movie});
}

final class GetMovieDetailsLoading extends GetMovieDetailsState {}

final class GetMovieDetailsError extends GetMovieDetailsState {
  final String error;

  GetMovieDetailsError(this.error);
}
