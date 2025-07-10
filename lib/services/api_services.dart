// ============================================================================
// SINGLETON PATTERN EXPLANATION
// ============================================================================

// What is Singleton?
// A Singleton ensures that a class has only ONE instance throughout the entire app
// and provides a global point of access to that instance.

// ============================================================================
// STEP 1: UNDERSTANDING THE SINGLETON STRUCTURE
// ============================================================================

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
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
      TvSeries tvSeries = TvSeries.fromJson(response.data);
      tvSeries.actors = await getTvseriesActors(tvseriesId);
      return tvSeries;
    } on DioException catch (e) {
      throw Exception(e.error);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Actor>> getTvseriesActors(int tvseriesId) async {
    try {
      Response response = await dio
          .get('$baseUrl/tv/$tvseriesId/aggregate_credits?api_key=$apiKey');
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

  Future<List<Movie>> getWatchlistMovies(
      int accountId, String sessionId) async {
    try {
      Response response = await dio.get(
          '$baseUrl/account/$accountId/watchlist/movies?api_key=$apiKey&session_id=$sessionId&sort_by=created_at.asc');
      Map<String, dynamic> jsonData = response.data;
      List<dynamic> movies = jsonData['results'];

      return movies.map((movie) => Movie.fromJson(movie)).toList();
    } on DioException catch (e) {
      throw Exception(e.error);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<TvSeries>> getWatchlistTvseries(
      int accountId, String sessionId) async {
    try {
      Response response = await dio.get(
          '$baseUrl/account/$accountId/watchlist/tv?api_key=$apiKey&session_id=$sessionId&sort_by=created_at.asc');
      Map<String, dynamic> jsonData = response.data;
      List<dynamic> tvseries = jsonData['results'];

      return tvseries.map((tvseries) => TvSeries.fromJson(tvseries)).toList();
    } on DioException catch (e) {
      throw Exception(e.error);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> addOrRemoveFromWatchlist(int mediaId, String mediaType,
      int accountId, String sessionId, bool inWatchlist) async {
    try {
      Response response = await dio.post(
        '$baseUrl/account/$accountId/watchlist?api_key=$apiKey&session_id=$sessionId',
        data: {
          'media_type': mediaType, // 'movie' or 'tv'
          'media_id': mediaId,
          'watchlist': inWatchlist, // true to add, false to remove
        },
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      debugPrint('Error adding to watchlist: $e');
      return false;
    }
  }

  Future<Map<String, bool>> getMovieAccountStates({
    required int movieId,
  }) async {
    try {
      final response = await dio.get(
        '$baseUrl/movie/$movieId/account_states',
      );

      if (response.statusCode == 200) {
        return {
          'favorite': response.data['favorite'] ?? false,
          'watchlist': response.data['watchlist'] ?? false,
          'rated': response.data['rated'] !=
              false, // rated can be false or a rating object
        };
      }
    } catch (e) {
      debugPrint('Error getting movie account states: $e');
    }

    return {
      'favorite': false,
      'watchlist': false,
      'rated': false,
    };
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
