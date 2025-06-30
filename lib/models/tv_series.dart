import 'package:movies_app/models/movie.dart';

class TvSeries {
  final int id;
  final String language;
  final String title;
  final String originalTitle;
  final String overView;
  final num popularity;
  final String poster;
  final num voteAvr;
  final num voteCount;
  final bool adult;
  final String firstAirDate;
  final String lastAirDate;
  final List<String> genres;
  final bool inProduction;
  final List<String> languages;
  final int nextEpisodeToAir;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountries;
  final String originalLanguage;
  final List<ProductionCompany> productioCompanies;
  final List<String> productionCountries;
  final List<Season> seasons;
  final List<String> spokenLanguage;
  final String status;
  final String tagline;
  final String type;
  final List<String> networks;

  TvSeries({
    required this.id,
    required this.language,
    required this.title,
    required this.originalTitle,
    required this.overView,
    required this.popularity,
    required this.poster,
    required this.firstAirDate,
    required this.voteAvr,
    required this.voteCount,
    required this.adult,
    required this.genres,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.nextEpisodeToAir,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountries,
    required this.originalLanguage,
    required this.productioCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguage,
    required this.status,
    required this.tagline,
    required this.type,
    required this.networks,
  });

  factory TvSeries.fromJson(Map<String, dynamic> json) {
    return TvSeries(
      id: json['id'] ?? 0,
      language: json['original_language'] ?? '',
      title: json['name'] ?? '',
      originalTitle: json['original_name'] ?? '',
      overView: json['overview'] ?? '',
      popularity: json['popularity'] ?? 0,
      poster: json['poster_path'] ?? '',
      firstAirDate: json['first_air_date'] ?? '',
      voteAvr: json['vote_average'] ?? 0,
      voteCount: json['vote_count'] ?? 0,
      adult: json['adult'] ?? false,
      genres: (json['genres'] as List<dynamic>?)
              ?.map((genre) => genre['name'].toString())
              .toList() ??
          [],
      inProduction: json['in_production'] ?? false,
      languages: (json['languages'] as List<dynamic>?)
              ?.map((language) => language.toString())
              .toList() ??
          [],
      lastAirDate: json['last_air_date'] ?? '',
      nextEpisodeToAir: json['next_episode_to_air'] == null
          ? 0
          : (json['next_episode_to_air']['episode_number'] ?? 0),
      numberOfEpisodes: json['number_of_episodes'] ?? 0,
      numberOfSeasons: json['number_of_seasons'] ?? 0,
      originCountries: (json['origin_country'] as List<dynamic>?)
              ?.map((country) => country.toString())
              .toList() ??
          [],
      originalLanguage: json['original_language'] ?? '',
      productioCompanies: (json['production_companies'] as List<dynamic>?)
              ?.map((company) => ProductionCompany.fromJson(company))
              .toList() ??
          [],
      productionCountries: (json['production_countries'] as List<dynamic>?)
              ?.map((country) => country['name'].toString())
              .toList() ??
          [],
      seasons: (json['seasons'] as List<dynamic>?)
              ?.map((season) => Season.fromJson(season))
              .toList() ??
          [],
      spokenLanguage: (json['spoken_languages'] as List<dynamic>?)
              ?.map((language) => language['english_name'].toString())
              .toList() ??
          [],
      status: json['status'] ?? '',
      tagline: json['tagline'] ?? '',
      type: json['type'] ?? '',
      networks: (json['networks'] as List<dynamic>?)
              ?.map((network) => network['name'].toString())
              .toList() ??
          [],
    );
  }
}

class Season {
  final int id;
  final int episodeCount;
  final int seasonNumber;
  final String airDate;
  final String name;
  final String overview;
  final String poster;
  final double voteAvr;

  Season({
    required this.airDate,
    required this.voteAvr,
    required this.seasonNumber,
    required this.poster,
    required this.overview,
    required this.name,
    required this.id,
    required this.episodeCount,
  });

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      airDate: json['air_date'] ?? '',
      voteAvr: json['vote_average'] ?? 0,
      seasonNumber: json['season_number'] ?? 0,
      poster: json['poster_path'] ?? '',
      overview: json['overview'] ?? '',
      name: json['name'] ?? '',
      id: json['id'] ?? 0,
      episodeCount: json['episode_count'] ?? 0,
    );
  }
}
