class Movie {
  final int id;
  final String language;
  final String title;
  final String originalTitle;
  final String overView;
  final num popularity;
  final String poster;
  final String releaseDate;
  final num voteAvr;
  final num voteCount;
  //
  final bool adult;
  final num budget;
  final List<Genre> genres;
  final String imdbId;
  final List<String> originCountry;
  final List<ProductionCompany> productionCompanies;
  final List<String> productionCountry;
  final num revenue;
  final num runtime;
  final String status;
  final String tagline;

  Movie({
    required this.id,
    required this.language,
    required this.title,
    required this.originalTitle,
    required this.overView,
    required this.popularity,
    required this.poster,
    required this.releaseDate,
    required this.voteAvr,
    required this.voteCount,
    required this.adult,
    required this.budget,
    required this.genres,
    required this.imdbId,
    required this.originCountry,
    required this.productionCompanies,
    required this.productionCountry,
    required this.revenue,
    required this.runtime,
    required this.status,
    required this.tagline,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      language: json['original_language'] ?? '',
      title: json['title'] ?? '',
      originalTitle: json['original_title'] ?? '',
      overView: json['overview'] ?? '',
      popularity: json['popularity'] ?? 0,
      poster: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? '',
      voteAvr: json['vote_average'] ?? 0,
      voteCount: json['vote_count'] ?? 0,
      adult: json['adult'] ?? false,
      budget: json['budget'] ?? 0,
      //? there is an explaination about this part in the end of the file
      genres: (json['genres'] as List<dynamic>?)
              ?.map((genrejson) => Genre.fromJson(genrejson))
              .toList() ??
          [],
      imdbId: json['imdb_id'] ?? '',
      originCountry: (json['origin_country'] as List<dynamic>?)
              ?.map((country) => country.toString())
              .toList() ??
          [],
      productionCompanies: (json['production_companies'] as List<dynamic>?)
              ?.map((companyjson) => ProductionCompany.fromJson(companyjson))
              .toList() ??
          [],
      productionCountry: (json['production_countries'] as List<dynamic>?)
              ?.map((countryjson) => countryjson['name'].toString())
              .toList() ??
          [],
      revenue: json['revenue'] ?? 0,
      runtime: json['runtime'] ?? 0,
      status: json['status'] ?? '',
      tagline: json['tagline'] ?? '',
    );
  }
}

class Genre {
  final int id;
  final String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

class ProductionCompany {
  final int id;
  final String logo;
  final String name;
  final String originalCountry;

  ProductionCompany({
    required this.id,
    required this.logo,
    required this.name,
    required this.originalCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) {
    return ProductionCompany(
      id: json['id'] ?? 0,
      logo: json['logo_path'] ?? '',
      name: json['name'] ?? '',
      originalCountry: json['origin_country'] ?? '',
    );
  }
}

class Country {
  final String iso;
  final String name;

  Country({
    required this.iso,
    required this.name,
  });
}


// Original line broken down:
//? genres: (json['genres'] as List<dynamic>?)
//?     ?.map((genreJson) => Genre.fromJson(genreJson))
//?     .toList() ?? [],

// Let's break this down step by step:

// STEP 1: Extract the genres from JSON
//? json['genres']
// This gets the value associated with the 'genres' key from the JSON map
// The value could be: null, a List, or something else entirely

// STEP 2: Safe casting with null safety
//? (json['genres'] as List<dynamic>?)
// This casts the value to List<dynamic>? (nullable list of dynamic objects)
// The '?' makes it nullable, so if casting fails, it returns null instead of throwing an error
// dynamic means each item in the list can be any type

// STEP 3: Null-aware operator
//? ?.map(...)
// The '?.' operator only executes if the left side is NOT null
// If json['genres'] was null or casting failed, this entire chain stops and returns null

// STEP 4: Mapping function
//? .map((genreJson) => Genre.fromJson(genreJson))
// map() transforms each item in the list
// For each item (called genreJson), it calls Genre.fromJson(genreJson)
// This converts each Map<String, dynamic> into a Genre object
// Returns an Iterable<Genre>

// STEP 5: Convert to List
//? .toList()
// Converts the Iterable<Genre> to List<Genre>
// This is necessary because map() returns an Iterable, not a List

// STEP 6: Null coalescing operator
//? ?? []
// If any step above returned null, use an empty list [] instead
// This ensures we always get a List<Genre>, never null