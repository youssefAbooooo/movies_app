import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/models/tv_series.dart';
import 'package:movies_app/services/api_services.dart';

part 'get_tvseries_details_state.dart';

class GetTvseriesDetailsCubit extends Cubit<GetTvseriesDetailsState> {
  GetTvseriesDetailsCubit() : super(GetTvseriesDetailsInitial());

  Future<void> getTvseriesDetials(int tvseriesId) async {
    emit(GetTvseriesDetailsLoading());
    try {
      TvSeries tvSeries =
          await ApiServices.instance.getTvseriesDetails(tvseriesId);
      emit(GetTvseriesDetailsLoaded(tvSeries: tvSeries));
    } catch (e) {
      emit(GetTvseriesDetailsError(e.toString()));
    }
  }
}
