import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  // void greet(){
  //   emit (HomeDisplayGreet());

  void getCarleslider(){
      emit (HomeCarouselMovieLoading());
  }
}
