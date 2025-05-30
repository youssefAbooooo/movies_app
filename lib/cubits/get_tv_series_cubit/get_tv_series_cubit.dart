import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/services/api_services.dart';

import '../../models/tv_series.dart';

part 'get_tv_series_state.dart';

class GetTvSeriesCubit extends Cubit<GetTvSeriesState> {
  GetTvSeriesCubit() : super(TvSeriesInitial());

  Future<void> getTvSeries() async {
    emit(TvSeriesLoading());

    final ApiServices apiServices = ApiServices();

    try {
      final List<TvSeries> airingToday =
          await apiServices.getTvSeriesWithCategory('airing_today');
      final List<TvSeries> onTheAir =
          await apiServices.getTvSeriesWithCategory('on_the_air');
      final List<TvSeries> popular =
          await apiServices.getTvSeriesWithCategory('popular');
      final List<TvSeries> topRated =
          await apiServices.getTvSeriesWithCategory('top_rated');

      emit(
        TvSeriesLoaded(
          airingToday: airingToday,
          onTheAir: onTheAir,
          popular: popular,
          topRated: topRated,
        ),
      );
    } on Exception catch (e) {
      emit(TvSeriesError(e.toString()));
    }
  }
}
