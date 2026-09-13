import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../data/models/movies_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void getCarouselMovies() async {
    emit(HomeCarouselMovieLoading());

    try {
      final dio = Dio();
      final response = await dio.get(
        "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1",
        options: Options(
          headers: {
            "Authorization":
                "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYmYwNzRjYzk3MzE0YmRiMWZmM2VlMmQ3NWUwNWY0ZiIsIm5iZiI6MTc2MTM5NzAxOS4xMDgsInN1YiI6IjY4ZmNjOTFiYzQzZDA1OTllMjkzODUwNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lzdT9GXoMtzophhJo7yb5wZ0MviXwdxUh7Lo1kVT1N4",
            "accept": "application/json",
          },
        ),
      );

      final movies = CarouselMoviesResponse.fromJson(response.data);
      emit(HomeCarouselMovieSuccess(movies: movies.results));
    } catch (e) {
      emit(HomeCarouselMovieError(message: e.toString()));
    }
  }
}
