part of 'watchlist_cubit.dart';

@immutable
sealed class WatchlistCubitState {}

final class WatchlistCubitInitial extends WatchlistCubitState {}

final class WatchlistCubitLoading extends WatchlistCubitState {}

final class WatchlistCubitLoaded extends WatchlistCubitState {
  final bool success;

  WatchlistCubitLoaded({required this.success});
}

final class WatchlistCubitError extends WatchlistCubitState {
  final String message;

  WatchlistCubitError(this.message);
}
