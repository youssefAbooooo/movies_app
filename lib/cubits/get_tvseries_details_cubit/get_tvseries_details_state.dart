part of 'get_tvseries_details_cubit.dart';

@immutable
sealed class GetTvseriesDetailsState {}

final class GetTvseriesDetailsInitial extends GetTvseriesDetailsState {}

final class GetTvseriesDetailsLoading extends GetTvseriesDetailsState {}

final class GetTvseriesDetailsLoaded extends GetTvseriesDetailsState {
  final TvSeries tvSeries;
  GetTvseriesDetailsLoaded({required this.tvSeries});
}

final class GetTvseriesDetailsError extends GetTvseriesDetailsState {
  final String error;
  GetTvseriesDetailsError(this.error);
}
