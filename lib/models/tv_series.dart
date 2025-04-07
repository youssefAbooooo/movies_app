class TvSeries {
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

  TvSeries(
      {required this.id,
      required this.language,
      required this.title,
      required this.originalTitle,
      required this.overView,
      required this.popularity,
      required this.poster,
      required this.releaseDate,
      required this.voteAvr,
      required this.voteCount});

  factory TvSeries.fromJson(Map<String, dynamic> json) {
    return TvSeries(
      id: json['id'],
      language: json['original_language'],
      title: json['title'],
      originalTitle: json['original_title'],
      overView: json['overview'],
      popularity: json['popularity'],
      poster: json['poster_path'],
      releaseDate: json['release_date'],
      voteAvr: json['vote_average'],
      voteCount: json['vote_count'],
    );
  }
}
