part of 'get_my_watchlist_cubit.dart';

@immutable
sealed class GetMyWatchlistState {}

final class GetMyWatchlistInitial extends GetMyWatchlistState {}

final class GetMyWatchlistLoading extends GetMyWatchlistState {}

final class GetMyWatchlistLoaded extends GetMyWatchlistState {
  final List<Movie> movies;
  final List<TvSeries> tvseries;

  GetMyWatchlistLoaded({
    required this.movies,
    required this.tvseries,
  });
}

final class GetMyWatchlistError extends GetMyWatchlistState {
  final String message;

  GetMyWatchlistError({required this.message});
}
