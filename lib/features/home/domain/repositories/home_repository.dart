import '../../data/models/movies_model.dart';

abstract class HomeRepository {
  Future<List<MovieModel>> getPopularMovies();
}
