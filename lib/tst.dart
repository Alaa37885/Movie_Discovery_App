import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3/',
      headers: {
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYmYwNzRjYzk3MzE0YmRiMWZmM2VlMmQ3NWUwNWY0ZiIsIm5iZiI6MTc2MTM5NzAxOS4xMDgsInN1YiI6IjY4ZmNjOTFiYzQzZDA1OTllMjkzODUwNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lzdT9GXoMtzophhJo7yb5wZ0MviXwdxUh7Lo1kVT1N4', // Replace with your bearer token
        'accept': 'application/json',
      },
    ),
  );

  // Fetch Runtime from GET /movie/{movie_id}
  Future<int?> getMovieRuntime(int movieId) async {
    try {
      final response = await _dio.get('movie/$movieId');
      return response.data['runtime'] as int?;
    } catch (e) {
      print('Error fetching movie details: $e');
      return null;
    }
  }

  // Fetch Cast from GET /movie/{movie_id}/credits
  Future<List<dynamic>> getMovieCast(int movieId) async {
    try {
      final response = await _dio.get('movie/$movieId/credits');
      return response.data['cast'] ?? [];
    } catch (e) {
      print('Error fetching cast: $e');
      return [];
    }
  }

  // Fetch Reviews from GET /movie/{movie_id}/reviews
  Future<List<dynamic>> getMovieReviews(int movieId) async {
    try {
      final response = await _dio.get('movie/$movieId/reviews');
      return response.data['results'] ?? [];
    } catch (e) {
      print('Error fetching reviews: $e');
      return [];
    }
  }
}