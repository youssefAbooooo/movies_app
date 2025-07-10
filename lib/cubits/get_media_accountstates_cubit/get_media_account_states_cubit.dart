import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/services/api_services.dart';

part 'get_media_account_states_state.dart';

enum MediaType { movie, tv }

class GetMediaAccountStatesCubit extends Cubit<GetMediaAccountStatesState> {
  GetMediaAccountStatesCubit() : super(GetMediaAccountStatesInitial());

  Future<void> getMediaAccountstates(
      int mediaId, String sessionId, MediaType mediaType) async {
    emit(GetMediaAccountStatesLoading());

    try {
      Map<String, bool> mediaAccountstates;
      if (mediaType == MediaType.movie) {
        mediaAccountstates = await ApiServices.instance
            .getMovieAccountStates(movieId: mediaId, sessionId: sessionId);
      } else {
        mediaAccountstates = await ApiServices.instance
            .getTvAccountStates(tvId: mediaId, sessionId: sessionId);
      }
      emit(
        GetMediaAccountStatesLoaded(
          favourite: mediaAccountstates['favorite']!,
          watchlist: mediaAccountstates['watchlist']!,
          rated: mediaAccountstates['rated']!,
        ),
      );
    } catch (e) {
      emit(GetMediaAccountStatesError(e.toString()));
    }
  }
}
