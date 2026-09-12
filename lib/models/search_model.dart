import 'movie_details_model.dart';

class SearchResponseModel {
  final int page;
  final List<SearchMovieModel> results;
  final int totalPages;
  final int totalResults;

  SearchResponseModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory SearchResponseModel.fromJson(Map<String, dynamic> json) {
    return SearchResponseModel(
      page: json['page'] ?? 0,
      results: (json['results'] as List<dynamic>?)
              ?.map((movie) => SearchMovieModel.fromJson(movie))
              .toList() ??
          [],
      totalPages: json['total_pages'] ?? 0,
      totalResults: json['total_results'] ?? 0,
    );
  }
}

class SearchMovieModel {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String title;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String? releaseDate;
  final bool video;
  final double voteAverage;
  final int voteCount;

  int? runtime;
  List<GenreModel> genres;

  SearchMovieModel({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.title,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    this.runtime,
    this.genres = const [],
  });

  factory SearchMovieModel.fromJson(Map<String, dynamic> json) {
    return SearchMovieModel(
      adult: json['adult'] ?? false,
      backdropPath: json['backdrop_path'],
      genreIds: (json['genre_ids'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          [],
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      originalLanguage: json['original_language'] ?? '',
      originalTitle: json['original_title'] ?? '',
      overview: json['overview'] ?? '',
      popularity: (json['popularity'] ?? 0).toDouble(),
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      video: json['video'] ?? false,
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
    );
  }
}
