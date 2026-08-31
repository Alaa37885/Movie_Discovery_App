part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class HomeDisplayGreet extends HomeState {}
final class HomeCarouselMovieLoading extends HomeState {}
final class HomeCarouselMovieSuccess extends HomeState {
  final List<MovieModel> movies;
  HomeCarouselMovieSuccess({required this.movies});
}
final class HomeCarouselMovieError extends HomeState {
  final String message;
  HomeCarouselMovieError({required this.message});
}
