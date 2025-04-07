part of 'get_tv_series_cubit.dart';

@immutable
sealed class GetTvSeriesState {}

final class TvSeriesInitial extends GetTvSeriesState {}

final class TvSeriesLoading extends GetTvSeriesState {}

final class TvSeriesLoaded extends GetTvSeriesState {
  final List<TvSeries> airingToday;
  final List<TvSeries> onTheAir;
  final List<TvSeries> popular;
  final List<TvSeries> topRated;

  TvSeriesLoaded({
    required this.airingToday,
    required this.onTheAir,
    required this.popular,
    required this.topRated,
  });
}

final class TvSeriesError extends GetTvSeriesState {
  final String message;

  TvSeriesError(this.message);
}
