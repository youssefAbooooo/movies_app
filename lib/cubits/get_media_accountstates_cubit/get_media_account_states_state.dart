part of 'get_media_account_states_cubit.dart';

@immutable
sealed class GetMediaAccountStatesState {}

final class GetMediaAccountStatesInitial extends GetMediaAccountStatesState {}

final class GetMediaAccountStatesLoading extends GetMediaAccountStatesState {}

final class GetMediaAccountStatesLoaded extends GetMediaAccountStatesState {
  final bool favourite;
  final bool watchlist;
  final bool rated;

  GetMediaAccountStatesLoaded({
    required this.favourite,
    required this.watchlist,
    required this.rated,
  });
}

final class GetMediaAccountStatesError extends GetMediaAccountStatesState {
  final String message;

  GetMediaAccountStatesError(this.message);
}
