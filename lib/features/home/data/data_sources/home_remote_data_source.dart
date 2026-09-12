import 'package:movie_nti_aug/core/network/dio_client.dart';
import '../models/movies_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<MovieModel>> getPopularMovies();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioClient _dioClient;

  HomeRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await _dioClient.get(
      "/discover/movie",
      queryParameters: {
        "include_adult": false,
        "include_video": false,
        "language": "en-US",
        "page": 1,
        "sort_by": "popularity.desc",
      },
    );

    final carouselResponse = CarouselMoviesResponse.fromJson(response.data);
    return carouselResponse.results;
  }
}
