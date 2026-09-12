import 'movies_model.dart';

class MovieDetailsModel {
  final int id;
  final String title;
  final String? backdropPath;
  final String? posterPath;
  final String overview;
  final String releaseDate;
  final double voteAverage;
  final int runtime;
  final List<GenreModel> genres;

  MovieDetailsModel({
    required this.id,
    required this.title,
    this.backdropPath,
    this.posterPath,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.runtime,
    required this.genres,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      backdropPath: json['backdrop_path'],
      posterPath: json['poster_path'],
      overview: json['overview'] ?? '',
      releaseDate: json['release_date'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      runtime: json['runtime'] ?? 0,
      genres: (json['genres'] as List<dynamic>? ?? [])
          .map((genre) => GenreModel.fromJson(genre))
          .toList(),
    );
  }

  MovieModel toMovieModel() {
    return MovieModel(
      adult: false,
      backdropPath: backdropPath,
      genreIds: genres.map((e) => e.id).toList(),
      id: id,
      title: title,
      originalLanguage: '',
      originalTitle: '',
      overview: overview,
      popularity: 0.0,
      posterPath: posterPath,
      releaseDate: releaseDate,
      softcore: false,
      video: false,
      voteAverage: voteAverage,
      voteCount: 0,
    );
  }
}

class GenreModel {
  final int id;
  final String name;

  GenreModel({
    required this.id,
    required this.name,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}