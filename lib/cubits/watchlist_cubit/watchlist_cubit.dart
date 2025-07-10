import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/services/api_services.dart';

part 'watchlist_state.dart';

class WatchlistCubit extends Cubit<WatchlistCubitState> {
  WatchlistCubit() : super(WatchlistCubitInitial());

  Future<void> addOrRemoveFromWatchlist(int mediaId, String mediaType,
      int accountId, String sessionId, bool inWatchlist) async {
    emit(WatchlistCubitLoading());

    try {
      bool success = await ApiServices.instance.addOrRemoveFromWatchlist(
          mediaId, mediaType, accountId, sessionId, inWatchlist);
      emit(WatchlistCubitLoaded(success: success));
    } catch (e) {
      emit(WatchlistCubitError('Error adding to watchlist: $e'));
    }
  }
}
