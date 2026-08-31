class PopularResponse {
  int? page;
  List<MovieModel>? results;
  int? totalPages;
  int? totalResults;

  PopularResponse({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  PopularResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];

    if (json['results'] != null) {
      results = <MovieModel>[];

      for (var movie in json['results']) {
        results!.add(MovieModel.fromJson(movie));
      }
    }

    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
}

class MovieModel {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? title;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  bool? softcore;
  bool? video;
  double? voteAverage;
  int? voteCount;

  MovieModel({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.title,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.softcore,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  MovieModel.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];

    if (json['genre_ids'] != null) {
      genreIds = List<int>.from(json['genre_ids']);
    }

    id = json['id'];
    title = json['title'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];

    popularity = (json['popularity'] as num?)?.toDouble();

    posterPath = json['poster_path'];
    releaseDate = json['release_date'];

    softcore = json['softcore'];
    video = json['video'];

    voteAverage = (json['vote_average'] as num?)?.toDouble();

    voteCount = json['vote_count'];
  }
}

