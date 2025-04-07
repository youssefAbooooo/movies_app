import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_movies_state.dart';

class GetMoviesCubit extends Cubit<GetMoviesState> {
  GetMoviesCubit() : super(GetMoviesInitial());
}
