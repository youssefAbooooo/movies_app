import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/models/tv_series.dart';
import 'package:movies_app/services/api_services.dart';

part 'get_my_watchlist_state.dart';

class GetMyWatchlistCubit extends Cubit<GetMyWatchlistState> {
  GetMyWatchlistCubit() : super(GetMyWatchlistInitial());

  Future<void> getWatchlist(int accountId, String sessionId) async {
    emit(GetMyWatchlistLoading());

    try {
      List<Movie> movies =
          await ApiServices.instance.getWatchlistMovies(accountId, sessionId);
      List<TvSeries> tvseries =
          await ApiServices.instance.getWatchlistTvseries(accountId, sessionId);
      emit(GetMyWatchlistLoaded(movies: movies, tvseries: tvseries));
    } catch (e) {
      emit(GetMyWatchlistError(message: e.toString()));
    }
  }
}
