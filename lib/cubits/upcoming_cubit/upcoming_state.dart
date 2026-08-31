part of 'upcoming_cubit.dart';

@immutable
sealed class UpcomingState {}

final class UpcomingInitial extends UpcomingState {}
final class getUpcomingLoading extends UpcomingState {}
final class getUpcomingSuccess extends UpcomingState {
  final List<MovieModel> movies;

  getUpcomingSuccess({required this.movies});
}
final class getUpcomingFailure extends UpcomingState {
  final String message;

  getUpcomingFailure({required this.message});
}
