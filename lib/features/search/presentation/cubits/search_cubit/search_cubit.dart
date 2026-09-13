import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:movie_nti_aug/features/movie_details/data/models/movie_details_model.dart';
import 'package:movie_nti_aug/features/search/data/models/search_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  void searchMovies(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }
    emit(SearchLoading());

    try {
      var dio = Dio();
      const headers = {
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYmYwNzRjYzk3MzE0YmRiMWZmM2VlMmQ3NWUwNWY0ZiIsIm5iZiI6MTc2MTM5NzAxOS4xMDgsInN1YiI6IjY4ZmNjOTFiYzQzZDA1OTllMjkzODUwNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lzdT9GXoMtzophhJo7yb5wZ0MviXwdxUh7Lo1kVT1N4",
        "accept": "application/json",
      };

      var res = await dio.get(
        "https://api.themoviedb.org/3/search/movie",
        queryParameters: {
          "query": query,
          "language": "en-US",
          "page": 1,
        },
        options: Options(
          headers: headers,
        ),
      );

      var response = SearchResponseModel.fromJson(res.data);
      
      // Fetch details for each movie to get runtime and genres
      final futures = response.results.map((movie) async {
        try {
          final detailsRes = await dio.get(
            "https://api.themoviedb.org/3/movie/${movie.id}",
            options: Options(headers: headers),
          );
          final details = MovieDetailsModel.fromJson(detailsRes.data);
          movie.runtime = details.runtime;
          movie.genres = details.genres;
        } catch (e) {
        }
      });

      await Future.wait(futures);

      emit(SearchSuccess(movies: response.results));
    } catch (e) {
      emit(SearchFailure(message: e.toString()));
    }
  }
}
