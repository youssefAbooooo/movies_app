import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/services/api_services.dart';

import '../../models/movie.dart';

part 'movie_details_state.dart';

class GetMovieDetailsCubit extends Cubit<GetMovieDetailsState> {
  GetMovieDetailsCubit() : super(GetMovieDetailsInitial());

  Future<void> getMovieDetails(int movieId) async {
    emit(GetMovieDetailsLoading());

    try {
      Movie movie = await ApiServices.instance.getMovieDetails(movieId);
      emit(GetMovieDetailsLoaded(movie: movie));
    } catch (e) {
      emit(GetMovieDetailsError(e.toString()));
    }
  }
}
