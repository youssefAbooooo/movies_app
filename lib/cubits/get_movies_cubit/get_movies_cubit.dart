import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/services/api_services.dart';

import '../../models/movie.dart';

part 'get_movies_state.dart';

class GetMoviesCubit extends Cubit<GetMoviesState> {
  GetMoviesCubit() : super(MoviesInitial());

  Future<void> getMovies() async {
    emit(MoviesLoading());

    ApiServices apiServices = ApiServices();

    try {
      final List<Movie> nowPlayingMovies =
          await apiServices.getMoviesWithCategory('now_playing');
      final List<Movie> popularMovies =
          await apiServices.getMoviesWithCategory('popular');
      final List<Movie> topRatedMovies =
          await apiServices.getMoviesWithCategory('top_rated');
      final List<Movie> upcomingMovies =
          await apiServices.getMoviesWithCategory('upcoming');

      emit(
        MoviesLoaded(
            nowPlayingMovies: nowPlayingMovies,
            popularMovies: popularMovies,
            topRatedMovies: topRatedMovies,
            upcomingMovies: upcomingMovies),
      );
    } on Exception catch (e) {
      emit(MoviesError(e.toString()));
    }
  }
}
