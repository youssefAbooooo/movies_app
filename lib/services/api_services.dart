import 'package:dio/dio.dart';
import 'package:movies_app/models/movie_or_tv_series.dart';

class ApiServices {
  final dio = Dio();

  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = '89d29d819af376ca1df5e06d6e7e3751';

  Future<List<MovieOrTvSeries>> getMoviesWithCategory(String category) async {
    //? categories are now_playing , popular , top_rated , upcoming
    try {
      Response response =
          await dio.get('$baseUrl/movie/$category?api_key=$apiKey');

      Map<String, dynamic> jsonData = response.data;

      List<dynamic> movies = jsonData['results'];

      List<MovieOrTvSeries> moviesList = [];

      for (var movie in movies) {
        moviesList.add(MovieOrTvSeries.fromJson(movie));
      }
      return moviesList;
    } on DioException catch (e) {
      throw Exception(e.error);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<MovieOrTvSeries>> getTvSeriesWithCategory(String category) async {
    //? categories are airing_today , on_the_air , popular , top_rated
    try {
      Response response =
          await dio.get('$baseUrl/tv/$category?api_key=$apiKey');

      Map<String, dynamic> jsonData = response.data;

      List<dynamic> tvSeries = jsonData['results'];

      List<MovieOrTvSeries> tvSeriesList = [];

      for (var oneTvSeries in tvSeries) {
        tvSeriesList.add(MovieOrTvSeries.fromJson(oneTvSeries));
      }
      return tvSeriesList;
    } on DioException catch (e) {
      throw Exception(e.error);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<MovieOrTvSeries>> searchForMovie(String movieName) async {
    try {
      Response response = await dio
          .get('$baseUrl/search/movie?api_key=$apiKey&query=$movieName');

      Map<String, dynamic> jsonData = response.data;

      List<dynamic> movies = jsonData['results'];

      List<MovieOrTvSeries> moviesList = [];

      for (var movie in movies) {
        moviesList.add(MovieOrTvSeries.fromJson(movie));
      }
      return moviesList;
    } on DioException catch (e) {
      throw Exception(e.error);
    } catch (e) {
      throw Exception(e);
    }
  }
}
