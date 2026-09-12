import '../../models/movies_model.dart';

abstract class WatchlistState {}

class WatchlistInitial extends WatchlistState {}

class WatchlistLoading extends WatchlistState {}

class WatchlistSuccess extends WatchlistState {
  final List<MovieModel> movies;
  WatchlistSuccess(this.movies);
}

class WatchlistFailure extends WatchlistState {
  final String message;
  WatchlistFailure(this.message);
}
