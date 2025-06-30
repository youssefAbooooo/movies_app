// ============================================================================
// SINGLETON PATTERN EXPLANATION
// ============================================================================

// What is Singleton?
// A Singleton ensures that a class has only ONE instance throughout the entire app
// and provides a global point of access to that instance.

// ============================================================================
// STEP 1: UNDERSTANDING THE SINGLETON STRUCTURE
// ============================================================================

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/models/tv_series.dart';

class ApiServices {
  // STEP 1A: Private Constructor
  // This prevents anyone from creating new instances using ApiServices()
  ApiServices._internal();

  // STEP 1B: Static Instance Variable
  // This holds the single instance of the class
  // It's created only once when first accessed
  static final ApiServices _instance = ApiServices._internal();

  // STEP 1C: Factory Constructor
  // When someone calls ApiServices(), this returns the existing instance
  factory ApiServices() => _instance;

  // STEP 1D: Instance Getter (Optional but recommended)
  // Provides cleaner access: ApiServices.instance
  static ApiServices get instance => _instance;

  // Your regular class members
  final dio = Dio();
  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = '89d29d819af376ca1df5e06d6e7e3751';

  // Your methods remain the same
  Future<List<Movie>> getMoviesWithCategory(String category) async {
    try {
      Response response =
          await dio.get('$baseUrl/movie/$category?api_key=$apiKey');
      Map<String, dynamic> jsonData = response.data;
      List<dynamic> movies = jsonData['results'];

      return movies.map((movie) => Movie.fromJson(movie)).toList();
    } on DioException catch (e) {
      throw Exception(e.error);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<TvSeries>> getTvSeriesWithCategory(String category) async {
    //? categories are airing_today , on_the_air , popular , top_rated
    try {
      Response response =
          await dio.get('$baseUrl/tv/$category?api_key=$apiKey');

      Map<String, dynamic> jsonData = response.data;

      List<dynamic> tvSeries = jsonData['results'];

      List<TvSeries> tvSeriesList = [];

      for (var oneTvSeries in tvSeries) {
        tvSeriesList.add(TvSeries.fromJson(oneTvSeries));
      }
      return tvSeriesList;
    } on DioException catch (e) {
      throw Exception(e.error);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Movie> getMovieDetails(int movieId) async {
    try {
      Response response =
          await dio.get('$baseUrl/movie/$movieId?api_key=$apiKey');
      Movie movie = Movie.fromJson(response.data);
      movie.actors = await getMovieActors(movieId);
      return movie;
    } on DioException catch (e) {
      throw Exception(e.error);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Actor>> getMovieActors(int movieId) async {
    try {
      Response response =
          await dio.get('$baseUrl/movie/$movieId/credits?api_key=$apiKey');
      List<Actor> actors = [];
      List<dynamic> jsonData = response.data['cast'];
      for (var i = 0; i < jsonData.length; i++) {
        actors.add(Actor.fromJson(jsonData[i]));
      }
      return actors;
    } on DioException catch (e) {
      throw Exception(e.error);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<TvSeries> getTvseriesDetails(int tvseriesId) async {
    try {
      Response response =
          await dio.get('$baseUrl/tv/$tvseriesId?api_key=$apiKey');
      return TvSeries.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.error);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Movie>> searchForMovie(String movieName) async {
    try {
      Response response = await dio
          .get('$baseUrl/search/movie?api_key=$apiKey&query=$movieName');
      Map<String, dynamic> jsonData = response.data;
      List<dynamic> movies = jsonData['results'];

      return movies.map((movie) => Movie.fromJson(movie)).toList();
    } on DioException catch (e) {
      throw Exception(e.error);
    } catch (e) {
      throw Exception(e);
    }
  }
}

// ============================================================================
// STEP 2: HOW TO USE THE SINGLETON
// ============================================================================

// METHOD 1: Using the factory constructor
void exampleUsage1() async {
  ApiServices apiService = ApiServices(); // This returns the singleton instance
  // ignore: unused_local_variable
  List<Movie> movies = await apiService.getMoviesWithCategory('popular');
}

// METHOD 2: Using the instance getter (RECOMMENDED)
void exampleUsage2() async {
  // ignore: unused_local_variable
  List<Movie> movies =
      await ApiServices.instance.getMoviesWithCategory('popular');
  // ignore: unused_local_variable
  Movie movieDetails = await ApiServices.instance.getMovieDetails(123);
  // ignore: unused_local_variable
  List<Movie> searchResults =
      await ApiServices.instance.searchForMovie('Avengers');
}
