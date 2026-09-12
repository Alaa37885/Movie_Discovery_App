import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_nti_aug/features/home/data/models/movies_model.dart';
import 'watchlist_state.dart';

class WatchlistCubit extends Cubit<WatchlistState> {
  WatchlistCubit() : super(WatchlistInitial()) {
    getWatchlist();
  }

  final List<MovieModel> _watchlist = [];

  void getWatchlist() {
    emit(WatchlistLoading());
    try {
      emit(WatchlistSuccess(List.from(_watchlist)));
    } catch (e) {
      emit(WatchlistFailure(e.toString()));
    }
  }

  void toggleWatchlist(MovieModel movie) {
    final index = _watchlist.indexWhere((m) => m.id == movie.id);
    if (index != -1) {
      _watchlist.removeAt(index);
    } else {
      _watchlist.add(movie);
    }
    emit(WatchlistSuccess(List.from(_watchlist)));
  }

  bool isInWatchlist(int movieId) {
    return _watchlist.any((m) => m.id == movieId);
  }
}
