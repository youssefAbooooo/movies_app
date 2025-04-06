import 'package:dio/dio.dart';
import 'package:movies_app/models/movie.dart';

class ApiServices {
  final dio = Dio();

  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = '89d29d819af376ca1df5e06d6e7e3751';

  Future<List<Movie>> getPopularMovies() async {
    try {
      Response response =
          await dio.get('$baseUrl/movie/popular?api_key=$apiKey');

      Map<String, dynamic> jsonData = response.data;

      List<dynamic> movies = jsonData['results'];

      List<Movie> moviesList = [];

      for (var movie in movies) {
        moviesList.add(Movie.fromJson(movie));
      }
      return moviesList;
    } on DioException catch (e) {
      throw Exception(e.error);
    } catch (e) {
      throw Exception(e);
    }
  }
}
