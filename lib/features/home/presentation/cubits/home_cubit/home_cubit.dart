import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:movie_nti_aug/features/home/domain/repositories/home_repository.dart';

import '../../../data/models/movies_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository homeRepository;
  
  HomeCubit(this.homeRepository) : super(HomeInitial());

  void getCarouselMovies() async{
      emit (HomeCarouselMovieLoading());

      try {
        final movies = await homeRepository.getPopularMovies();
        emit(HomeCarouselMovieSuccess(movies : movies));
    } catch (e) {
        emit(HomeCarouselMovieError(message: e.toString()));
      }
  }
}
